//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI

let BUTTON_HEIGHT: CGFloat = 65.0

var flowerEmojis = ["💐","🌼","🌸","🌷","🌺","🌻","🌹","💮", "🌱", "🌳"]
var dartmouthEmojis = ["🌲","🍾","🍷","📚","📘","🥂","🍻","🏓"]
var californiaEmojis = ["☀️","🏄🏼‍♀️","🏝","🌉","👩‍💻","📱","🌁","😎", "🏖"]


struct ContentView: View {
    
    @State var emojis = flowerEmojis
    @State var themeColor = Color.purple
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let numberOfCards = Int.random(in: 4...emojis.count) // select random number of cards
                let preferredWidth = getPreferredWidth(height: geometry.size.height, width: geometry.size.width, nCards: numberOfCards) // calculate a good width for the number of cards
                
                ScrollView {
                    Text("Memorize")
                        .bold()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    // the preferred maximum is an upper bound, adaptive picks a good size given a range
                    // so we select from a range of (preferredWidth - 60, preferredWidth - 30)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: preferredWidth - 60, maximum: preferredWidth - 30))]) {
                        ForEach(emojis[0..<numberOfCards], id: \.self) { emoji in
                            CardView(content: emoji)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
            }
            .foregroundColor(themeColor)
            Spacer()
            HStack {
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
                    emojis = dartmouthEmojis.shuffled()
                    themeColor = Color.green
                },
                   label: {
                Image.init(systemName: "sparkle")
               })
            Spacer()
            Text("Dartmouth")
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .frame(height: BUTTON_HEIGHT)
        .padding()
    }
    
    var flowerButton: some View {
        VStack{
        Button(action:
                {
                    emojis = flowerEmojis.shuffled()
                    themeColor = Color.purple
                },
               label: {
                Image.init(systemName: "leaf")
               })
            Spacer()
            Text("Flowers")
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .frame(height: BUTTON_HEIGHT)
        .padding()

    }
    
    var californiaButton: some View {
        VStack{
        Button(action:
                {
                    emojis = californiaEmojis.shuffled()
                    themeColor = Color.blue
                },
               label: {
                Image.init(systemName: "sun.max.fill")
               })
            Spacer()
            Text("California")
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .frame(height: BUTTON_HEIGHT)
        .padding()

    }
    
    func getPreferredWidth(height: CGFloat, width: CGFloat, nCards: Int) -> CGFloat {
        let totalArea = height * width
        let cardArea = totalArea / CGFloat(nCards)
        
        // math (2x * 3x = cardArea) -> solve for x -> return 2x
        let cardWidth = (cardArea / 6.0).squareRoot() * 2.0
        
        return cardWidth
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
