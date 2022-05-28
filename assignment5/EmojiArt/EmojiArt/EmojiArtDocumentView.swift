//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry, emojiOffset: false))
                )
                .gesture(doubleTapToZoom(in: geometry.size).exclusively(before: deselectOnTap()))
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    ForEach(document.emojis) { emoji in
                        ZStack {
                            if (selectedEmoji.contains(emoji)) {
                                Rectangle()
                                    .stroke(.red)
                                    .frame(width: selectBoxSize(for: emoji), height: selectBoxSize(for: emoji))
                            }
                            Text(emoji.text)
                                .font(.system(size: fontSize(for: emoji)))
                                .onTapGesture {
                                    withAnimation {
                                        select(emoji)
                                    }
                                }
                            if (selectedEmoji.contains(emoji)) {
                                ZStack {
                                    Image(systemName: "multiply.circle")
                                        .foregroundColor(.white)
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .font(.system(size: fontSize(for: emoji) / 2))
                                .onTapGesture {
                                    withAnimation {
                                        document.remove(emoji)
                                        selectedEmoji.toggleMembership(of: emoji)
                                    }
                                }
                                .offset(x: selectBoxSize(for: emoji) / 2, y: -selectBoxSize(for: emoji) / 2)
                            }
                        }
                        .scaleEffect(zoomScale)
                        .position(position(for: emoji, in: geometry))
                        .gesture(panSelectedEmojiGesture())
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(panGesture().simultaneously(with: zoomGesture()))
        }
    }
    
    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Selecting/Deleting Emoji
    @State private var selectedEmoji: Set<EmojiArtModel.Emoji> = []
    
    private func select(_ emoji: EmojiArtModel.Emoji) {
        selectedEmoji.toggleMembership(of: emoji)
    }
    
    private func selectBoxSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size) * 1.2
    }
    
    private func deselectOnTap() -> some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    selectedEmoji.removeAll()
                }
            }
    }
    
    // MARK: - Positioning/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry, emojiOffset: selectedEmoji.contains(emoji))
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x - emojiGesturePanOffset.width) / zoomScale,
            y: (location.y - panOffset.height - center.y - emojiGesturePanOffset.height) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy, emojiOffset: Bool) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width + (emojiOffset ? emojiGesturePanOffset.width : 0.0),
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height + (emojiOffset ? emojiGesturePanOffset.height : 0.0)
        )
    }
    
    // MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                steadyStateZoomScale *= gestureScaleAtEnd
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    // MARK: - Panning
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                if (selectedEmoji.isEmpty) {
                    gesturePanOffset = latestDragGestureValue.translation / zoomScale
                }
            }
            .onEnded { finalDragGestureValue in
                if (selectedEmoji.isEmpty) {
                    steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
                }
            }
    }
    
    @GestureState private var emojiGesturePanOffset: CGSize = CGSize.zero
    
    private func panSelectedEmojiGesture() -> some Gesture {
        DragGesture()
            .updating($emojiGesturePanOffset) { latestDragGestureValue, emojiGesturePanOffset, _ in
                if (!selectedEmoji.isEmpty) {
                    emojiGesturePanOffset = latestDragGestureValue.translation
                }
            }
            .onEnded { finalDragGestureValue in
                selectedEmoji.forEach { emoji in
                    document.moveEmoji(emoji, by: finalDragGestureValue.translation / zoomScale)
                }
                selectedEmoji.removeAll()
            }
    }
    
    // MARK: - Palette
    
    var palette: some View {
        ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😀😷🦠💉👻👀🐶🌲🌎🌞🔥🍎⚽️🚗🚓🚲🛩🚁🚀🛸🏠⌚️🎁🗝🔐❤️⛔️❌❓✅⚠️🎶➕➖🏳️"
}

struct ScrollingEmojisView: View {
    let emojis: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
