//
//  Memorize.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/9/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    // setting variable is private, looking is okay though. called Access Control!
    private(set) var cards: Array<Card>
    
    init(numberPairs: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        
        // add numberPairs x 2 cards to array
        for pairIndex in 0..<max(2,numberPairs) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id:"\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
        
    }
    
    var indexofOnlyFaceUpCard: Int? {
        //computed prop
        get{return cards.indices.filter{ index in cards[index].isFaceUp }.only}
        set{return cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}}

    }
    
    mutating func choose(card:Card){
        //        card.isFaceUp = false
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexofOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
//                    indexofOnlyFaceUpCard = nil
                } else {
                    indexofOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            //            cards[chosenIndex].isFaceUp.toggle()
        }
    
    }
    // this is to make sure that a copy on write is needed.
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
//    mutating func newGame {
//        card
//    }
    //namespace is MemoryGame.Card
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
        
              
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            lhs.isMatched == rhs.isMatched &&
//            lhs.content == rhs.content
//        } DO NOT NEED IF JUST EQUALS EQUALS COMPARISONS
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        
    }
    
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil // can use these since we are extending array
    }
}
