//
//  EmojiMemoryGameView.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/6/25.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    
    
    var viewModel: EmojiMemoryGameVM
    
    let halloweenEmojis : [String] = ["🕷️","👻","🎃","💀","🕷️","👻","🎃","💀"]
    let valentinesEmojis : [String] = ["💕","❤️","🌹","😍","💕","❤️","🌹","😍","🥰","🥰"]
    let christmasEmojis: [String] = ["🎅","🎁","🎄","🦌","🎅","🎁","🎄","🦌", "❄️", "❄️" ,"⛸️", "⛸️"]
    // can also do : [String] = ["","","",""]
    @State var selectedEmojis: [String] = []
    @State var background_color: Color = Color.white
    @State var card_color: Color = Color.black
    var body: some View {
        
        Color(background_color).ignoresSafeArea().overlay(
            VStack () {
                Text("Memorize!").font(.largeTitle)
                ScrollView{
                    cards
                    //cardCountAdjusters
                }
                themes
            }.padding()
        )
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
            ForEach(0..<selectedEmojis.count,id: \.self){ index in
                CardView(content: selectedEmojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(card_color)
    }
    var themes: some View {
        return HStack {
            VStack{
                Button(action: {
                    selectedEmojis = christmasEmojis.shuffled()
                    background_color = Color.green
                    card_color = Color.blue
                }, label: {Image(systemName: "snowflake").imageScale(.large).font(.largeTitle).frame(height: 50)})
                Text("Christmas")}
            VStack{
                Button(action: {
                    selectedEmojis = halloweenEmojis.shuffled()
                    background_color = Color.gray
                    card_color = Color.orange
                }, label: {Image(systemName: "cat.fill").imageScale(.large).font(.largeTitle).frame(height: 50)})
                Text("Halloween")}
            VStack{
                Button(action: {
                    selectedEmojis = valentinesEmojis.shuffled()
                    background_color = Color.white
                    card_color = Color.red
                }, label: {Image(systemName: "suit.heart.fill").imageScale(.large).font(.largeTitle).frame(height: 50)})
                Text("Valentines")}
        }
    }
}

//    var cardCountAdjusters: some View {
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }.imageScale(.large)
//        .font(.largeTitle)
//    }
    //first name is external, second name is internal (by v. offset)
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action : {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    var cardRemover: some View {
//        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
//    }
//    var cardAdder: some View {
//        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
//        }
//}

struct CardView : View {
    // cannot be let since the cardview will set.
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        
        //view modifier to make tap change
        
        ZStack () {
            // let means the variable will never change, var will change
            // type inference
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
//                    .foregroundStyle(.red)
                base
                    .strokeBorder(lineWidth: 10).stroke(Color.black)
                Text(content)
                    .font(.largeTitle)
                    .foregroundColor(.black)
              
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().stroke(Color.black).opacity(isFaceUp ? 0 : 1)
         
            
        } // tap gesture logs taps when you click on the vstack
        .onTapGesture(perform: {
            // temporary state, for small animation things, not saving game state ect...
            //            isFaceUp = !isFaceUp
            // has toggle since it is a struct that has functions on it
            //View are immutable! they cannot be changed
            isFaceUp.toggle()
        })
                
    }
}

#Preview {
    EmojiMemoryGameView()
}
