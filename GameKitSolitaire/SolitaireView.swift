//
//  SolitaireView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct SolitaireView: View {
    @EnvironmentObject var solitaireGame: SolitaireGame
    @State var cardClicked: Bool
    @State var selectedCard: card?
    
    
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack {
                    ForEach(0..<7) { index in
                        Image(solitaireGame.piles[index].isEmpty ? "" : solitaireGame.piles[index][0].model)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.7)
                            .onTapGesture {
                                if !solitaireGame.piles[index].isEmpty {
                                    if cardClicked{
                                        solitaireGame.moveCard(selectedCard: selectedCard!, index: index)
                                        cardClicked = false
                                    }
                                    else{
                                        cardClicked = true
                                        selectedCard = solitaireGame.piles[index][0]
                                        solitaireGame.selectedPile = index
                                    }
                                }
                            }
                    }
                }
                .padding(50)
                
                HStack{
                    Image(solitaireGame.sidePiles[0].isEmpty ? "hearts_1":solitaireGame.sidePiles[0][0].model).resizable()
                        .scaledToFit()
                        .opacity(solitaireGame.sidePiles[0].isEmpty ? 0.5 : 1.0)
                        .scaleEffect(0.5)
                        .onTapGesture {
                                if cardClicked{
                                    solitaireGame.addToStack(selectedCard: selectedCard!, index: 0)
                                    cardClicked = false
                                }
                                else{
                                    if !solitaireGame.sidePiles[0].isEmpty{
                                        cardClicked = true
                                        selectedCard = solitaireGame.sidePiles[0][0]
                                        solitaireGame.selectedPile = 8
                                    }
                                }
                        }
                    Image(solitaireGame.sidePiles[1].isEmpty ? "diamonds_1":solitaireGame.sidePiles[1][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[1].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.5)
                        .onTapGesture {
                                if cardClicked{
                                    solitaireGame.addToStack(selectedCard: selectedCard!, index: 1)
                                    cardClicked = false
                                }
                                else{
                                    
                                    if !solitaireGame.sidePiles[1].isEmpty{
                                        cardClicked = true
                                        selectedCard = solitaireGame.sidePiles[1][0]
                                        solitaireGame.selectedPile = 9
                                    }
                                }
                        }
                    Image(solitaireGame.sidePiles[2].isEmpty ? "clubs_1":solitaireGame.sidePiles[2][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[2].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.5)
                        .onTapGesture {
                                if cardClicked{
                                    solitaireGame.addToStack(selectedCard: selectedCard!, index: 2)
                                    cardClicked = false
                                }
                                else{
                                    
                                    if !solitaireGame.sidePiles[2].isEmpty{
                                        cardClicked = true
                                        selectedCard = solitaireGame.sidePiles[2][0]
                                        solitaireGame.selectedPile = 10
                                    }
                                }
                        }
                    Image(solitaireGame.sidePiles[3].isEmpty ? "spades_1":solitaireGame.sidePiles[3][0].model).resizable()
                        .opacity(solitaireGame.sidePiles[3].isEmpty ? 0.5 : 1.0)
                        .scaledToFit()
                        .scaleEffect(0.5)
                        .onTapGesture {
                            if cardClicked{
                                solitaireGame.addToStack(selectedCard: selectedCard!, index: 3)
                                cardClicked = false
                            }
                                else{
                                    
                                    if !solitaireGame.sidePiles[3].isEmpty{
                                        cardClicked = true
                                        selectedCard = solitaireGame.sidePiles[3][0]
                                        solitaireGame.selectedPile = 11
                                    }
                                }
                        }
                    Spacer()
                    if let currentCard = solitaireGame.currentCard{
                        Image(currentCard.model)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.5)
                            .onTapGesture {
                                cardClicked = true
                                selectedCard = currentCard
                                solitaireGame.selectedPile = 12
                            }
                    } else {
                        Image("")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.5)
                    }
                    
                    // The card image positioned at the bottom-right
                    Image(solitaireGame.playerDeck.endofDeck ? "refresh" :"back05")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.5)
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
        SolitaireView(cardClicked: false, selectedCard: nil)
            .environmentObject(SolitaireGame()) // Properly pass the StateObject here
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


