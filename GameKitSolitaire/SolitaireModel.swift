//
//  WarModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 4/3/25.
//

import SwiftUI

class SolitaireGame: ObservableObject{
    @Published var playerDeck: deck
    @Published var unusedPile: [card]
    @Published var currentCard: card?
    @Published var piles: [[card]]
    @Published var gameOver: Bool
    @Published var sidePiles: [[card]]
    


    
    init(){
        playerDeck = deck()
        piles = []
        gameOver = false
        currentCard = nil
        unusedPile = []
        sidePiles = []
        for _ in 1...4{
            sidePiles.append([])
        }
        for count in 1...7{
            piles.append(playerDeck.deal(PlayerCount: 1, cardCount: count)[0].cardPile)
        }
        print(piles[0].count)
        print(piles[1].count)
        print(piles[2].count)
        print(piles[3].count)
        print(piles[4].count)
        print(piles[5].count)
        print(piles[6].count)
        print(playerDeck.cardPile.count)
    }
    
    func moveCard(selectedCard: card, index: Int){
        let pileCard = piles[index][0]
        if pileCard.color != selectedCard.color && ((pileCard.rank - selectedCard.rank) == 1){
                print("moved")
            }else {
                print("invalid move")
            }
    }
    
    func addToStack(selectedCard: card, index: Int){
        if !sidePiles[index].isEmpty {
            let stackCard = sidePiles[index][0]
            if stackCard.suit == selectedCard.suit && ((selectedCard.rank - stackCard.rank) == 1){
                sidePiles[index].insert(selectedCard, at: 0)
                removeFromPile(card: selectedCard)
            }else {
                print("invalid move")
            }
        } else if index == 0 && selectedCard.suit == "hearts"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile(card: selectedCard)
        }else if index == 1 && selectedCard.suit == "diamonds"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile(card: selectedCard)
        }else if index == 2 && selectedCard.suit == "clubs"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile(card: selectedCard)
        }else if index == 3 && selectedCard.suit == "spades"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile(card: selectedCard)
        }
    }
    
    func removeFromPile(card: card){
        if card.model == unusedPile[unusedPile.count-1].model{
            unusedPile.removeLast()
        } else {
            for index in 1...7{
                if card.model == piles[index-1][0].model{
                    piles[index].removeFirst()
                }
            }
        }

    }
    func resetGame(){

    }
    
}
