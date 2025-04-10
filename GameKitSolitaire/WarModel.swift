//
//  WarModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 4/3/25.
//

import SwiftUI

class WarGame: ObservableObject {
    @Published var playerOneDeck: [Card]
    @Published var playerTwoDeck: [Card]
    @Published var p1Card: Card?
    @Published var p2Card: Card?
    @Published var centerString: String
    @Published var cardsForGrabs: [Card]
    @Published var gameOver: Bool
    
    enum drawOutcome {
        case p1
        case p2
        case tie
    }
    
    init() {
        let deck: Deck = Deck()
        deck.populate()
        let playerDecks = deck.deal(playerCount: 2, cardCount: 26)
        playerOneDeck = playerDecks[0]
        playerTwoDeck = playerDecks[1]
        centerString = ""
        p1Card = nil
        p2Card = nil
        cardsForGrabs = []
        gameOver = false
    }
    
    func resetGame() {
        let deck: Deck = Deck()
        deck.populate()
        let playerDecks = deck.deal(playerCount: 2, cardCount: 26)
        playerOneDeck = playerDecks[0]
        playerTwoDeck = playerDecks[1]
        centerString = ""
        p1Card = nil
        p2Card = nil
        cardsForGrabs = []
        gameOver = false
    }
    
    func compareCards() -> drawOutcome {
        cardsForGrabs.append(p1Card!)
        cardsForGrabs.append(p2Card!)
        if p1Card! > p2Card! {
            centerString = "Your card is higher, you win the cards!"
            playerOneDeck.append(contentsOf: cardsForGrabs)
            cardsForGrabs.removeAll()
            return drawOutcome.p1
        } else if p2Card! > p1Card! {
            centerString = "Your card is lower, you lose the cards!"
            playerTwoDeck.append(contentsOf: cardsForGrabs)
            cardsForGrabs.removeAll()
            return drawOutcome.p2
        } else{
            centerString = "WAR! Flip Again!"
            return drawOutcome.tie
        }
        
    }
    
    
}
