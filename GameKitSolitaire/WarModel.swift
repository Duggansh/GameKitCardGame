//
//  WarModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 4/3/25.
//

import SwiftUI

class WarGame: ObservableObject{
    @Published var playerOneDeck: deck
    @Published var playerTwoDeck: deck
    @Published var p1Card: card?
    @Published var p2Card: card?
    @Published var isMyTurn: Bool
    
    init(){
        let deck: deck = deck()
        deck.populate()
        let playerDecks = deck.deal(PlayerCount: 2, cardCount: 26)
        playerOneDeck = playerDecks[0]
        playerTwoDeck = playerDecks[1]
        isMyTurn = true
        p1Card = nil
        p2Card = nil
    }
    
    
}
