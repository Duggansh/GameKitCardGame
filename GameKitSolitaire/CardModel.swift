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
    var color: String
}

class deck {
    
    @Published var cardPile: [card] = []
    @Published var drawnCards: [card] = []
    @Published var endofDeck: Bool = false
    
    init() {
        populate()
        for _ in 1...10 {
            shuffle()
        }
    }
    
    init(cards: [card]){
        cardPile = cards
        shuffle()
    }
    
    func populate(){
        for count in 1...13{
            cardPile.append(card(suit: "clubs", rank: count, shown: false, model: "clubs_\(count)" ,color: "black"))
            cardPile.append(card(suit: "hearts", rank: count, shown: false, model: "hearts_\(count)",color: "red"))
            cardPile.append(card(suit: "diamonds", rank: count, shown: false, model: "diamonds_\(count)",color: "red"))
            cardPile.append(card(suit: "spades", rank: count, shown: false, model: "spades_\(count)", color: "black"))
        }
    }
    
    func deal(PlayerCount: Int, cardCount: Int) -> [deck]{
        var deckList: [deck] = []
        for _ in (1...PlayerCount){
            var tempDeck: [card] = []
            for _ in (1...cardCount){
                tempDeck.append(draw()!)
            }
            deckList.append(deck(cards: tempDeck))
        }
        return deckList
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
