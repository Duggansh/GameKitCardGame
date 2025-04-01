//
//  CardModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct card{
    var suit: String
    var rank: Int
    var shown: Bool
    var model: String
}

class GameState: ObservableObject {
    @Published var currentCard: card?
}

class deck {
    
    @Published var cardPile: [card] = []
    @Published var drawnCards: [card] = []
    @Published var endofDeck: Bool = false
    
    init() {
        populate()
        shuffle()
    }
    
    func populate(){
        for count in 1...2{
            cardPile.append(card(suit: "clubs", rank: count, shown: false, model: "clubs_\(count)" ))
            cardPile.append(card(suit: "hearts", rank: count, shown: false, model: "hearts_\(count)"))
            cardPile.append(card(suit: "diamonds", rank: count, shown: false, model: "diamonds_\(count)"))
            cardPile.append(card(suit: "spades", rank: count, shown: false, model: "spades_\(count)"))
        }
    }
    
    func shuffle() {
        cardPile.shuffle()
    }
    
    func draw() -> card? {
        if (cardPile.count > 0){
            let drawnCard = cardPile[0]
            drawnCards.append(drawnCard)
            cardPile.removeFirst()
            return drawnCard
        }
        else{
            return nil
        }
    }
    
    
    
}
