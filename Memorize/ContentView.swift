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
