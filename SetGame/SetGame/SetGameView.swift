//
//  ContentView.swift
//  SetGame
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: BasicSetGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: setGame.table, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture { setGame.select(card) }
            }
            Spacer()
            HStack {
                Button(action: setGame.newGame) {
                    Text("New Game").font(.title)
                }
                .padding(50)
                Spacer()
                Button(action: setGame.dealThreeMoreCards) {
                    Text("3 More Cards").font(.title)
                }
                .padding(50)
            }
        }
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: DrawingConstant.cornerRadius)
                if card.isSelected {
                    cardShape.stroke(.blue, lineWidth: DrawingConstant.lineWidth)
                } else {
                    cardShape.stroke(.black, lineWidth: DrawingConstant.lineWidth)
                }
                
                if let isSet = card.isSet {
                    if isSet {
                        cardShape.stroke(.green, lineWidth: DrawingConstant.lineWidth)
                    } else {
                        cardShape.stroke(.red, lineWidth: DrawingConstant.lineWidth)
                    }
                }
                
                let content = contentShapeAndShading
                    .foregroundColor(contentColor)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 6)
                VStack {
                    ForEach(0..<card.number) { _ in
                        content
                    }
                }
            }
        }
    }
    
    // Apply shade to shape and return
    @ViewBuilder
    private var contentShapeAndShading: some View {
        switch card.shape {
        case .diamond:
            switch card.shading {
            case .open:
                Diamond().stroke()
            case .solid:
                Diamond()
            case .striped:
                Diamond().opacity(0.1)
            }
        case .oval:
            switch card.shading {
            case .open:
                Capsule().stroke()
            case .solid:
                Capsule()
            case .striped:
                Capsule().opacity(0.1)
            }
        case .rectangle:
            switch card.shading {
            case .open:
                Rectangle().stroke()
            case .solid:
                Rectangle()
            case .striped:
                Rectangle().opacity(0.1)
            }
        }
    }
    
    private var contentColor: Color {
        switch card.color {
        case .purple:
            return Color.purple
        case .brown:
            return Color.brown
        case .orange:
            return Color.orange
        }
    }
    
    private struct DrawingConstant {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(setGame: BasicSetGame())
    }
}
 
