//
//  SolitaireView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct SolitaireView: View {
    var cardDeck: deck = deck()
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            HStack{
                if let currentCard = gameState.currentCard{
                    Image(currentCard.model)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.3)
                } else {
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.3)
                }
                // The card image positioned at the bottom-right
                Image(cardDeck.endofDeck ? "refresh" :"back05")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.3)
                    .frame(width: .infinity, height: .infinity, alignment: .bottomTrailing)
                    .onTapGesture {
                        if cardDeck.cardPile.count > 0{
                            gameState.currentCard = cardDeck.draw()
                            if cardDeck.cardPile.count == 0{
                                cardDeck.endofDeck = true
                            }
                        } else {
                            cardDeck.cardPile = cardDeck.drawnCards
                            gameState.currentCard = nil
                            cardDeck.endofDeck = false
                        }
                    }
                        
            }
        }
    }
}

struct SolitaireView_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize the GameState and pass it via environmentObject
        SolitaireView()
            .environmentObject(GameState()) // Properly pass the StateObject here
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


