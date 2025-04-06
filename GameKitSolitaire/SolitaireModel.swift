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
    
    func resetGame(){

    }
    
}
