//
//  ContentView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-15.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        CardGameView(model: CardGameViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
