//
//  SolitaireView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct SolitaireView: View {
    @EnvironmentObject var solitaireGame: SolitaireGame
    
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack{
                    Image(solitaireGame.piles[0].isEmpty ? "": solitaireGame.piles[0][0].model).resizable()
                            .scaledToFit()
                            .scaleEffect(0.5)
                    
                    Image(solitaireGame.piles[1].isEmpty ? "": solitaireGame.piles[1][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    Image(solitaireGame.piles[2].isEmpty ? "":solitaireGame.piles[2][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    Image(solitaireGame.piles[3].isEmpty ? "":solitaireGame.piles[3][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    Image(solitaireGame.piles[4].isEmpty ? "":solitaireGame.piles[4][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    Image(solitaireGame.piles[5].isEmpty ? "":solitaireGame.piles[5][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                    Image(solitaireGame.piles[6].isEmpty ? "":solitaireGame.piles[6][0].model).resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
                } .padding(50)
                HStack{
                    Image(solitaireGame.sidePiles[0].isEmpty ? "hearts_1":solitaireGame.sidePiles[0][0].model).resizable()
                        .scaledToFit()
                        .opacity(solitaireGame.sidePiles[0].isEmpty ? 0.5 : 1.0)
                        .scaleEffect(0.3)
                    Image(solitaireGame.sidePiles[1].isEmpty ? "diamonds_1":solitaireGame.sidePiles[1][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[1].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.3)
                    Image(solitaireGame.sidePiles[2].isEmpty ? "clubs_1":solitaireGame.sidePiles[2][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[2].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.3)
                    Image(solitaireGame.sidePiles[3].isEmpty ? "spades_1":solitaireGame.sidePiles[3][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[3].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.3)
                    Spacer()
                    if let currentCard = solitaireGame.currentCard{
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
                    Image(solitaireGame.playerDeck.endofDeck ? "refresh" :"back05")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.3)
                        .frame(width: .infinity, height: .infinity, alignment: .bottomTrailing)
                        .onTapGesture {
                            if solitaireGame.playerDeck.cardPile.count > 0{
                                solitaireGame.currentCard = solitaireGame.playerDeck.draw()
                                solitaireGame.unusedPile.append(solitaireGame.currentCard!)
                                if solitaireGame.playerDeck.cardPile.count == 0{
                                    solitaireGame.playerDeck.endofDeck = true
                                }
                            } else {
                                solitaireGame.playerDeck.cardPile = solitaireGame.unusedPile
                                solitaireGame.currentCard = nil
                                solitaireGame.playerDeck.endofDeck = false
                            }
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
            .environmentObject(SolitaireGame()) // Properly pass the StateObject here
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


