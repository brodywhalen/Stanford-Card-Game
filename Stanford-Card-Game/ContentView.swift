//
//  ContentView.swift
//  Stanford-Card-Game
//
//  Created by Brody Whalen on 4/6/25.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView : View {
    // cannot be let since the cardview will set.
    @State var isFaceUp: Bool = false
    var body: some View {
        
        //view modifier to make tap change
        
        ZStack () {
            // let means the variable will never change, var will change
            // type inference
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base
                    .foregroundStyle(.white)
                base
                    .strokeBorder(lineWidth: 10)
                Text("Hello, world!")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            } else {
                base //.fill is standard
            }
         
            
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
    ContentView()
}
