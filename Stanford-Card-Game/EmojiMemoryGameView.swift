//
//  EmojiMemoryGameView.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/6/25.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    //@state inside a view, comes into existence when on a screen, and then deleted when the view is taken away.
    @ObservedObject var viewModel: EmojiMemoryGameVM
    
//    let halloweenEmojis : [String] = ["🕷️","👻","🎃","💀","🕷️","👻","🎃","💀"]
//    let valentinesEmojis : [String] = ["💕","❤️","🌹","😍","💕","❤️","🌹","😍","🥰","🥰"]
//    let christmasEmojis: [String] = ["🎅","🎁","🎄","🦌","🎅","🎁","🎄","🦌", "❄️", "❄️" ,"⛸️", "⛸️"]
    // can also do : [String] = ["","","",""]
//    @State var selectedEmojis: [String] = []
//    @State var background_color: Color = Color.white
//    @State var card_color: Color = Color.black //
    var body: some View {
        
//        Color(background_color).ignoresSafeArea().overlay(
            VStack () {
                Text("Memorize!").font(.largeTitle)
                ScrollView{
                    cards // the card has to conform to equitable
                        .animation(.default, value: viewModel.cards)
                    //cardCountAdjusters
                }
                // game title
                Text(viewModel.theme.getTitle()).font(.largeTitle)
                Text("Score")
                Text("\(viewModel.score)")
                
                HStack {
                    Button("Shuffle"){
                        viewModel.shuffle()
                    }
                    Button("New Game"){
                        viewModel.newGame()
                    }
                }

                
//                themes
            }.padding()
//        )
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){ card in
                CardView(card, color: viewModel.ThemeColor)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
//        .foregroundColor(card_color)
    }
//    var themes: some View {
//        return HStack {
//            VStack{
//                Button(action: {
////                    selectedEmojis = christmasEmojis.shuffled()
////                    background_color = Color.green
////                    card_color = Color.blue
//                }, label: {Image(systemName: "snowflake").imageScale(.large).font(.largeTitle).frame(height: 50)})
//                Text("Christmas")}
//            VStack{
//                Button(action: {
////                    selectedEmojis = halloweenEmojis.shuffled()
////                    background_color = Color.gray
////                    card_color = Color.orange
//                }, label: {Image(systemName: "cat.fill").imageScale(.large).font(.largeTitle).frame(height: 50)})
//                Text("Halloween")}
//            VStack{
//                Button(action: {
////                    selectedEmojis = valentinesEmojis.shuffled()
////                    background_color = Color.white
////                    card_color = Color.red
//                }, label: {Image(systemName: "suit.heart.fill").imageScale(.large).font(.largeTitle).frame(height: 50)})
//                Text("Valentines")}
//        }
//    }
}


struct CardView : View {
    // cannot be let since the cardview will set.
    let card: MemoryGame<String>.Card
    let color: Color
    
    init(_ card: MemoryGame<String>.Card, color: Color) {
        self.card = card
        self.color = color
    }
    
    var body: some View {
        
        //view modifier to make tap change
        
        ZStack () {
            // let means the variable will never change, var will change
            // type inference
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .foregroundStyle(.white)
                base
                    .strokeBorder(lineWidth: 10).stroke(color)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1.90,contentMode: .fit)
                    .foregroundColor(color)
              
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill(color).stroke(color).opacity(card.isFaceUp ? 0 : 1)
         
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
//        .onTapGesture(perform: {
//            card.isFaceUp.toggle()
//        })
                
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameVM())
}
