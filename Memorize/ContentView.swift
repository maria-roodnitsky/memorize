//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI


struct ContentView: View {
    let emojis = ["🌲", "🙂", "🥰", "😇", "🌺"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack{
                deleteButton
                Spacer()
                addButton
            }
        }
        .padding(.horizontal)
        .font(.largeTitle)
    }
    
    var addButton: some View {
        Button(action: {
            if emojiCount < emojis.count {
            emojiCount += 1
            }
        }, label: {
                Image(systemName: "plus.circle")
            })
    }
    
    var deleteButton: some View {
        Button(action: {
            if emojiCount > 1 {
            emojiCount -= 1
            }
            
        }, label: {
                Image(systemName: "minus.circle")
            })
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
