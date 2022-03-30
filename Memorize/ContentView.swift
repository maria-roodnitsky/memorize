//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI

let flowerEmojis = ["💐","🌼","🌸","🌷","🌺","🌻","🌹","💮", "🌱", "🌳"]
let dartmouthEmojis = ["🌲","🍾","🍷","📚","📘","🥂","🍻","🏓"]
let californiaEmojis = ["☀️","🏄🏼‍♀️","🏝","🌉","👩‍💻","📱","🌁","😎", "🏖"]


struct ContentView: View {
    
    @State var emojis = flowerEmojis
    @State var themeColor = Color.purple
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Memorize")
                    .bold()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(themeColor)
            Spacer()
            HStack{
                dartmouthButton
                Spacer()
                flowerButton
                Spacer()
                californiaButton
            }
        }
        .padding()
        .font(.largeTitle)
    }
    
    var dartmouthButton: some View {
        VStack{
        Button(action:
                {
                    emojis = shuffle(cards: dartmouthEmojis)
                    themeColor = Color.green
                },
               label: {
                Image.init(systemName: "sparkle")
               })
        Text("Dartmouth")
                    .font(.footnote)
        }
    }
    
    var flowerButton: some View {
        VStack{
        Button(action:
                {
                    emojis = shuffle(cards: flowerEmojis)
                    themeColor = Color.purple
                },
               label: {
                Image.init(systemName: "leaf")
               })
        Text("Flowers")
                .font(.footnote)
        }
    }
    
    var californiaButton: some View {
        VStack{
        Button(action:
                {
                    emojis = shuffle(cards: californiaEmojis)
                    themeColor = Color.blue
                },
               label: {
                Image.init(systemName: "sun.max.fill")
               })
            Text("California")
                .font(.footnote)
        }
    }
    
    func shuffle(cards: Array<String>) -> Array<String> {
        var shuffledCards = cards
        
        for i in 0..<cards.count {
            let randomIndex = Int.random(in: 0..<cards.count)
            shuffledCards.swapAt(i, randomIndex)
        }
        
        return shuffledCards
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack{
            let cardShape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                cardShape.foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 3)
                Text(content)
            } else {
                cardShape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
