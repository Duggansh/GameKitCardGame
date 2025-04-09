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
    @Published var piles: [[card]]
    @Published var gameOver: Bool
    @Published var sidePiles: [[card]]
    @Published var selectedPile: Int?
    @Published var refreshTrigger = false

    


    
    init(){
        playerDeck = deck()
        piles = []
        gameOver = false
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
        if selectedCard.rank == 13 && piles[index].isEmpty {
            piles[index].append(selectedCard)
            removeFromPile()
            return
        }
        
        let pileCard = piles[index][0]
        if pileCard.color != selectedCard.color && ((pileCard.rank - selectedCard.rank) == 1){
                print("moved")
            piles[index].insert(selectedCard, at: 0)
            removeFromPile()
            }else {
                print("invalid move")
            }
    }
    
    func addToStack(selectedCard: card, index: Int){
        if !sidePiles[index].isEmpty {
            let stackCard = sidePiles[index][0]
            if stackCard.suit == selectedCard.suit && ((selectedCard.rank - stackCard.rank) == 1){
                sidePiles[index].insert(selectedCard, at: 0)
                removeFromPile()
            }else {
                print("invalid move")
            }
        } else if index == 0 && selectedCard.suit == "hearts"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile()
        }else if index == 1 && selectedCard.suit == "diamonds"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile()
        }else if index == 2 && selectedCard.suit == "clubs"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile()
        }else if index == 3 && selectedCard.suit == "spades"  && selectedCard.rank == 1{
            sidePiles[index].append(selectedCard)
            removeFromPile()
        }
    }
    
    func removeFromPile(){
        if selectedPile! > 7 {
            switch selectedPile {
            case 8:
                print(sidePiles[0])
                sidePiles[0].removeFirst()
                refreshTrigger.toggle()
                print(sidePiles[0])
                break
            case 9:
                sidePiles[1].removeFirst()
                refreshTrigger.toggle()
                break
            case 10:
                sidePiles[2].removeFirst()
                refreshTrigger.toggle()
                break
            case 11:
                sidePiles[3].removeFirst()
                refreshTrigger.toggle()
                break
            case 12:
                unusedPile.removeLast()
                refreshTrigger.toggle()
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
