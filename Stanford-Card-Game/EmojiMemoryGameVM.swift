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
    @Published private(set) var theme: Theme
    @Published private var model: MemoryGame<String>
    // create 6 themes to be randomly chosen from to start the game. Should include, a name, number of pairs, and color to draw the cards.
    private let pairs: Int
    
    init () {
        self.pairs = 6
        let theme = Theme.allCases.randomElement()!
        self.theme  = theme
        self.model = EmojiMemoryGameVM.createMemoryGame(theme: theme, pairs: pairs)
    }
    
    enum Theme: CaseIterable {
                        
        case halloween
        case christmas
        case fourthOfJuly
        case valentines
        case saintPaddies
        case chineseNewYear
        
        func getThemedEmojis(numCards: Int) -> [String] {
                   
            
            switch self {
                case.halloween:
                    return Array<String>(["🎃","👻","💀","🕷️"].shuffled().prefix(numCards))
                case.christmas:
                return Array<String>(["🎅","🎁","🎄","🦌","❄️","⛸️" ].shuffled().prefix(numCards))
                case.fourthOfJuly:
                    return Array<String>(["🇺🇸","🍔","🌭","🎆"].shuffled().prefix(numCards))
                case.valentines:
                    return Array<String>(["🌹","❤️","🥰","💕"].shuffled().prefix(numCards))
                case.saintPaddies:
                    return Array<String>(["☘️","🍻","🇮🇪","🍀"].shuffled().prefix(numCards))
                case.chineseNewYear:
                    return Array<String>(["🧧","🥠","🎉","🐍"].shuffled().prefix(numCards))
            }
        }
        
        func getTitle() -> String {
            
            switch self {
                case.halloween: return "Halloween"
                case.christmas: return "Christmas"
                case.fourthOfJuly: return " Fourth of July"
                case.valentines: return "Valentines"
                case.saintPaddies: return "Saint Paddy's"
                case.chineseNewYear: return "Chinese New Year"
            }
        }
        
        func getColor() -> String {
            switch self {
                case.halloween: return ".Orange"
                case.christmas: return ".Blue"
                case.fourthOfJuly: return ".Red"
                case.valentines: return ".Pink"
                case.saintPaddies: return ".Green"
                case.chineseNewYear: return ".Gold"
            }
        }
        
    }
    // get emojis
    
    
//    static private let emojis = Theme.allCases.randomElement()!.getThemedEmojis(pairs: 4)
    
    
    
    
    private static func createMemoryGame(theme: Theme, pairs: Int) -> MemoryGame<String>{
        
//        let pairs = 4
//        let theme = Theme.allCases.randomElement()!
        let emojis = theme.getThemedEmojis(numCards: pairs)
                    
        
        return MemoryGame(numberPairs: pairs){ index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
        
        }
    }
    
//    var objectWillChange: ObservableObjectPublisher
    // private keeps this scoped to the class, preventing access from the View through viewModel.model
    
    
    

        
    
    // intent functions
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -Intents
    func shuffle() {
//        model.cards.shuffle()  //cannot use mutatating member on an immutable value
        model.shuffle()
        print(model)
        objectWillChange.send()
    }
    func newGame(){
        let newTheme = Theme.allCases.randomElement()!
        self.theme = newTheme
        self.model = EmojiMemoryGameVM.createMemoryGame(theme: newTheme, pairs: pairs )
        objectWillChange.send()
    }
    
    // _ means the external name does not exist, so we would not need to put the name in.
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    
    
}
