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
    var isFaceUp: Bool = false
    var body: some View {
        if isFaceUp {
            ZStack (content  : {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 10)
                Text("Hello, world!")
                    .font(.largeTitle)
                    .foregroundColor(.black)

            })
        } else {
           RoundedRectangle(cornerRadius: 12)
        }

    }
}






#Preview {
    ContentView()
}
