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
    @Published var message: String
    @Published var roundIsOver: Bool
    
    init(numPlayers: Int) {
        self.roundIsOver = false
        self.numPlayers = numPlayers
        self.playerTurn = 0
        self.drawPile = Deck() // a new shuffled deck
        message = "Your Turn!"
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
    
    func resetGame() {
        self.roundIsOver = false
        self.numPlayers = numPlayers
        self.playerTurn = 0
        self.drawPile = Deck() // a new shuffled deck
        message = "Your Turn!"
        startGame()
    }
    
    func drawCard(playerIndex: Int, numCards: Int) {
        var drawSuccessful: Bool = false
        if !roundIsOver {
            for _ in 0..<numCards {
                if let drawnCard = drawPile.draw() {
                    playerHands[playerIndex].append(drawnCard)
                    
                    if playerIndex == 0 {
                        message = "You drew a card"
                    }
                    else {
                        message = "Bot \(playerTurn) drew a card."
                    }
                    drawSuccessful = true
                }
                else {
                    message = "Cannot draw card"
                }
            }
            if drawSuccessful {
                nextTurn()
            }
        }
    }
    
    func playCard(playerIndex: Int, card: Card) {
        if !roundIsOver {
            if playerTurn != 0 {
                message = "It is not your turn!"
                return
            }
            
            // basic logic for playing a card
            if card.suit == discardPile.last?.suit || card.rank == discardPile.last?.rank || card.rank == "8" && playerIndex == playerTurn  {
                // remove the card from the player's hand
                playerHands[playerIndex].removeAll {$0 == card}
                discardPile.append(card)
                
                if card.rank == "8" {
                    message = "You're feeling crazy!"
                }
                else if card.rank == "2" {
                    message = "You played a draw 2!"
                }
                else {
                    message = "You played \(card.rank) of \(card.suit)"
                }
                nextTurn()
            }
            else {
                message = "Invalid Play!"
            }
        }
    }
    
    func botPlayTurn() {
        if !roundIsOver {
            // check for if there are any valid cards to play
            var validCardFound = false
            
            for i in 0..<playerHands[playerTurn].count {
                let card = playerHands[playerTurn][i] // the card the bot is looking at
                
                if card.suit == discardPile.last?.suit || card.rank == discardPile.last?.rank {
                    validCardFound = true
                    if card.rank == "2" {
                        message = "Bot \(playerTurn) played a draw 2!"
                    }
                    else {
                        message = "Bot \(playerTurn) played \(card.rank) of \(card.suit)"
                    }
                }
                else if card.rank == "8" {
                    validCardFound = true
                    message = "Bot \(playerTurn) is feeling crazy!"
                }
                
                if validCardFound {
                    // play the card
                    playerHands[playerTurn].remove(at: i)
                    discardPile.append(card)
                    break
                }
            }
            
            if !validCardFound {
//                if let drawnCard = drawPile.draw() {
//                    playerHands[playerTurn].append(drawnCard)
//                    message = "Bot \(playerTurn) drew a card."
//                    
//                }
//                else {
//                    message = "Cannot draw card"
//                }
                drawCard(playerIndex: playerTurn, numCards: 1)
            }
            else {
                nextTurn()
            }
        }
    }
    
    func nextTurn() {
        checkRoundStatus()
        
        playerTurn = (playerTurn + 1) % numPlayers
        
        print(discardPile.last!)
        
        if discardPile.last!.rank == "2" {
            print("2 2 2")
        }
        
        // let bots play after the player's turn
        if playerTurn >= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.botPlayTurn()  // Pass the function as a closure
            }
        }
        
        if playerTurn == 0 {
            message = "Your Turn!"
        }
    }

    func checkRoundStatus() {
        // check if any player has no cards left
        if playerHands.contains(where: { $0.isEmpty }) {
            roundIsOver = true
            if playerTurn == 0 {
                message = "You win the round!"
            }
            else {
                message = "Bot \(playerTurn) has won the round!"
            }
            return
        }
        
        // check if the draw pile is empty and no one can make a valid move
        if drawPile.cardPile.isEmpty {
            drawPile.cardPile = discardPile.shuffled()
            
            // start the discard pile with a single card
            if let startingCard = drawPile.draw() {
                discardPile.append(startingCard)
            }
            return
        }
        
        roundIsOver = false
    }
}
