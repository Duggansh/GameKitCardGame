//
//  SolitaireView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI

struct SolitaireView: View {
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            HStack{
                Spacer()
                // The card image positioned at the bottom-right
                Image("back05")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.3)
                    .frame(width: .infinity, height: .infinity, alignment: .bottomTrailing)
                
            }
        }
    }
}

struct SolitaireView_Previews: PreviewProvider {
    static var previews: some View {
        SolitaireView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

