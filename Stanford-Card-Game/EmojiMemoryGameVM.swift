//
//  EmojiMemoryGameVM.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/9/25.
//

//  This is the view model
//  needs to know about the ui
import SwiftUI
//class because it is shared

//func createCardContent(forPairAtIndex index: Int) -> String {
//        return ["🎅","🎁","🎄","🦌","❄️","⛸️" ][index]
//}
class EmojiMemoryGameVM: ObservableObject {
    // all vars need default values in a class
    
    // makes it global namespace it inside the class, EmojiMemoryGameVM.emojis
    
    // create 6 themes to be randomly chosen from to start the game. Should include, a name, number of pairs, and color to draw the cards.
    enum Theme: String, CaseIterable {
        case halloween
        case christmas
        case fourthOfJuly
        case valentines
        case saintPaddies
        case chineseNewYear
        
        func getThemedEmojis() -> [String] {
            switch self {
                case.halloween: return ["🎃","👻","💀","🕷️"]
                case.christmas: return ["🎅","🎁","🎄","🦌","❄️","⛸️" ]
                case.fourthOfJuly: return ["🇺🇸","🍔","🌭","🎆"]
                case.valentines: return ["🌹","❤️","🥰","💕"]
                case.saintPaddies: return ["☘️","🍻","🇮🇪","🍀"]
                case.chineseNewYear: return ["🧧","🥠","🎉","🐍"]
            }
        }
        
    }
    // get emojis
    
    
//    static private let emojis = Theme.allCases.randomElement()!.getThemedEmojis(pairs: 4)
    
    
    
    
    private static func createMemoryGame() -> MemoryGame<String>{
        
        let theme = Theme.allCases.randomElement()!
        let emojis = theme.getThemedEmojis()
        
        return MemoryGame(numberPairs: 4){ index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
            
            
        }
    }
    
//    var objectWillChange: ObservableObjectPublisher
    // private keeps this scoped to the class, preventing access from the View through viewModel.model
    @Published private var model = EmojiMemoryGameVM.createMemoryGame()
    
    

        
    
    // intent functions
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: -Intents
    func shuffle() {
//        model.cards.shuffle()  //cannot use mutatating member on an immutable value
        model.shuffle()
        objectWillChange.send()
    }
    func newGame(){
        model = EmojiMemoryGameVM.createMemoryGame()
        objectWillChange.send()
    }
    
    // _ means the external name does not exist, so we would not need to put the name in.
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    
    
}
