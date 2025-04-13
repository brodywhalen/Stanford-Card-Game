//
//  Stanford_Card_GameApp.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/6/25.
//

import SwiftUI

@main
struct Stanford_Card_GameApp: App {
    
    @StateObject var game = EmojiMemoryGameVM()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
