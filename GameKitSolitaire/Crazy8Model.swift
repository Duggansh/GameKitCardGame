//
//  Crazy8Model.swift
//  GameKitSolitaire
//
//  Created by Skyler J. Burden on 4/10/25.
//

import SwiftUI

class Crazy8Game: ObservableObject {
    @Published var numPlayers: Int = 4
    @Published var playerTurn: Int = 0
    @Published var drawPile: Deck
    @Published var discardPile: [Card] = []
    @Published var playerHands: [[Card]] = []
    
    init(numPlayers: Int) {
        self.numPlayers = numPlayers
        self.drawPile = Deck() // a new shuffled deck
        startGame()
    }
    
    func startGame() {
        // deal 7 cards to each player
        playerHands = drawPile.deal(playerCount: numPlayers, cardCount: 7)
        
        // start the discard pile with a single card
        if let startingCard = drawPile.draw() {
            discardPile.append(startingCard)
        }
    }
    
    func drawCardForPlayer(playerIndex: Int) {
        if playerIndex != playerTurn {
            print("It is not your turn!")
            return
        }
        
        if let drawnCard = drawPile.draw() {
            playerHands[playerIndex].append(drawnCard)
        }
        else {
            print("Cannot draw card")
        }
    }
    
    func playCard(playerIndex: Int, card: Card) {
        // basic logic for playing a card
        if card.suit == discardPile.last?.suit || card.rank == discardPile.last?.rank && playerIndex == playerTurn {
            // remove the card from the player's hand
            playerHands[playerIndex].removeAll {$0 == card}
            discardPile.append(card)
            nextTurn()
        }
        else {
            print("Invalid play!")
        }
    }
    
    func botPlayTurn() {
        // check for if there are any valid cards to play
        var validCardFound = false
        
        for i in 0..<playerHands[playerTurn].count {
            let card = playerHands[playerTurn][i] // the card the bot is looking at
            
            if card.suit == discardPile.last?.suit || card.rank == discardPile.last?.rank {
                // play the card
                playerHands[playerTurn].remove(at: i)
                discardPile.append(card)
//                playCard(playerIndex: playerTurn, card: card)
                validCardFound = true
                print("Bot \(playerTurn) Played \(card.rank) of \(card.suit)")
                break
            }
        }
        
        if !validCardFound {
            drawCardForPlayer(playerIndex: playerTurn)
            print("Bot \(playerTurn) drew a card.")
        }
        
        nextTurn()
    }
    
    func nextTurn() {
        playerTurn = (playerTurn + 1) % numPlayers
        
        // let bots play after the player's turn
        if playerTurn >= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.botPlayTurn()  // Pass the function as a closure
            }
        }
    }
}
