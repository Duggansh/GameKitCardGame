//
//  CardModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct Card: Comparable, Equatable, Hashable {
    var suit: String
    var rank: String
    var shown: Bool
    var model: String
    var color: String
    var aceisHigh: Bool = true
    
    // conform to Comparible
    static func < (lhs: Card, rhs: Card) -> Bool {
        func getRankValue(card: Card) -> Int {
            switch card.rank {
            case "A":
                // might in the future not want to have ace is high tied to card
                return card.aceisHigh ? 14 : 1
            case "J":
                return 11
            case "Q":
                return 12
            case "K":
                return 13
            default:
                return Int(card.rank)!
            }
        }
        
        let lhsValue: Int = getRankValue(card: lhs)
        let rhsValue: Int = getRankValue(card: rhs)

        return lhsValue < rhsValue
    }
    
    // conform to Equatable
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
    
    // conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(suit)
        hasher.combine(rank)
    }
}

class Deck {
    
    @Published var cardPile: [Card] = []
    @Published var drawnCards: [Card] = []
    @Published var endofDeck: Bool = false
    
    init() {
        populate()
        shuffle()
    }
    
    init(cards: [Card]){
        cardPile = cards
        shuffle()
    }
    
    func populate() {
        let ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in ["clubs", "hearts", "diamonds", "spades"] {
            for rank in ranks {
                let color = (suit == "hearts" || suit == "diamonds") ? "red" : "black"
                cardPile.append(Card(suit: suit, rank: rank, shown: false, model: "\(suit)_\(rank)", color: color))
            }
        }
    }
    
    func deal(playerCount: Int, cardCount: Int) -> [[Card]] {
        var hands: [[Card]] = []
        for _ in 1...playerCount {
            var hand: [Card] = []
            for _ in 1...cardCount {
                if let drawnCard = draw() {
                    hand.append(drawnCard)
                }
            }
            hands.append(hand)
        }
        return hands
    }
    
    func shuffle() {
        cardPile.shuffle()
    }
    
    func draw() -> Card? {
        if cardPile.isEmpty {
            endofDeck = true
            return nil
        }
        let drawnCard = cardPile.removeFirst()
        drawnCards.append(drawnCard)
        return drawnCard
    }
}

