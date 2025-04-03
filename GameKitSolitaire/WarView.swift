//
//  WarView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 4/3/25.
//

import SwiftUI

struct WarView: View {
    @EnvironmentObject var warGame: WarGame
    
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Image("back07").resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                    Text("Cards left: \(warGame.playerTwoDeck.cardPile.count)").foregroundColor(.yellow)
                }
                Image("").resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                Spacer()
                Image(warGame.p1Card == nil ? "" : warGame.p1Card!.model).resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                HStack{
                    Text("Cards left: \(warGame.playerOneDeck.cardPile.count)").foregroundColor(.yellow)
                    Image("back05").resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                } .onTapGesture {
                    if warGame.playerOneDeck.cardPile.count > 0{
                        warGame.p1Card = warGame.playerOneDeck.draw()!
                    }
                }
                
            }
        }
        }
}
    struct WarView_Previews: PreviewProvider {
        static var previews: some View {
            // Initialize the GameState and pass it via environmentObject
            WarView().environmentObject(WarGame())
        }
    }
    

