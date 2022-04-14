//
//  ContentView.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI

let BUTTON_HEIGHT: CGFloat = 65.0

struct ContentView: View {

    @ObservedObject var viewModel: EmojiMemorizeViewModel
    
    var body: some View {
        VStack {
                ScrollView {
                    Text("Memorize")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text(viewModel.theme.name)
                        Spacer()
                        Text("Score: \(viewModel.score)")
                    }
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                    .foregroundColor(viewModel.theme.color)
            }
            newGameButton
        }
        .padding()
        .font(.largeTitle)
    }

        
    var newGameButton: some View {
        Button(action: { viewModel.newGame() }, label: { Text("New Game") })
    }
}

struct CardView: View {
    let card: EmojiMemorizeModel<String>.Card
    
    var body: some View {
        ZStack{
            let cardShape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                cardShape.foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 3)
                Text(card.content)
            } else if card.isMatched {
                cardShape.opacity(0)
            } else {
                cardShape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemorizeViewModel()
        ContentView(viewModel: viewModel)
    }
}
