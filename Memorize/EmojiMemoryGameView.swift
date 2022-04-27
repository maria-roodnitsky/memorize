//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI

let BUTTON_HEIGHT: CGFloat = 65.0

struct EmojiMemoryGameView: View {

    @ObservedObject var game: EmojiMemorizeViewModel
    
    var body: some View {
        VStack {
                    Text("Memorize")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text(game.theme.name)
                        Spacer()
                        Text("Score: \(game.score)")
                    }
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                cardView(for: card)
            }
                    .foregroundColor(game.theme.color)
            newGameButton
        }
        .padding()
        .font(.largeTitle)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemorizeModel<String>.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
        CardView(card: card)
            .padding(4)
            .onTapGesture {
                game.choose(card)
            }
        }
    }
        
    var newGameButton: some View {
        Button(action: { game.newGame() }, label: { Text("New Game") })
    }
}

struct CardView: View {
    let card: EmojiMemorizeModel<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    cardShape.foregroundColor(.white)
                    cardShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90)).padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    cardShape.opacity(0)
                } else {
                    cardShape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: size.width / 2)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemorizeViewModel()
        EmojiMemoryGameView(game: viewModel)
    }
}
