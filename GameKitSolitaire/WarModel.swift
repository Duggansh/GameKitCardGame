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
    @Published var centerString: String
    @Published var cardsForGrabs: [card]
    @Published var gameOver: Bool
    
    enum drawOutcome{
        case p1
        case p2
        case tie
    }
    
    init(){
        let deck: deck = deck()
        deck.populate()
        let playerDecks = deck.deal(PlayerCount: 2, cardCount: 26)
        playerOneDeck = playerDecks[0]
        playerTwoDeck = playerDecks[1]
        centerString = ""
        p1Card = nil
        p2Card = nil
        cardsForGrabs = []
        gameOver = false
    }
    
    func resetGame(){
        let deck: deck = deck()
        deck.populate()
        let playerDecks = deck.deal(PlayerCount: 2, cardCount: 26)
        playerOneDeck = playerDecks[0]
        playerTwoDeck = playerDecks[1]
        centerString = ""
        p1Card = nil
        p2Card = nil
        cardsForGrabs = []
        gameOver = false
    }
    
    func compareCards() -> drawOutcome{
        cardsForGrabs.append(p1Card!)
        cardsForGrabs.append(p2Card!)
        if p1Card!.rank == 1{
            p1Card!.rank = 14
        }
        if p2Card!.rank == 1{
            p2Card!.rank = 14
        }
        if p1Card!.rank > p2Card!.rank{
            centerString = "Your card is higher, you win the cards!"
            playerOneDeck.cardPile.append(contentsOf: cardsForGrabs)
            cardsForGrabs.removeAll()
            return drawOutcome.p1
        } else if p2Card!.rank > p1Card!.rank{
            centerString = "Your card is lower, you lose the cards!"
            playerTwoDeck.cardPile.append(contentsOf: cardsForGrabs)
            cardsForGrabs.removeAll()
            return drawOutcome.p2
        } else{
            centerString = "WAR! Flip Again!"
            return drawOutcome.tie
        }
        
    }
    
    
}
