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
    @Published var selectedPile: Int?
    


    
    init(){
        playerDeck = deck()
        piles = []
        gameOver = false
        currentCard = nil
        unusedPile = []
        sidePiles = []
        selectedPile = nil
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
        if selectedPile! > 7 {
            switch selectedPile {
            case 8:
                sidePiles[0].removeFirst()
                break
            case 9:
                sidePiles[1].removeFirst()
                break
            case 10:
                sidePiles[2].removeFirst()
                break
            case 11:
                sidePiles[3].removeFirst()
                break
            case 12:
                unusedPile.removeLast()
            default:
                break
            }
        } else {
            piles[selectedPile!].removeFirst()
        }


    }
    
    func resetGame(){

    }
    
}
