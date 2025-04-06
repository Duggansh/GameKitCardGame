//
//  ContentView.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 3/25/25.
//

import SwiftUI
import GameKit

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("Card Games").font(.system(size: 32))
                Spacer()
                NavigationLink("Play War", destination: WarView().environmentObject(WarGame()))
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameState()) // Initialize and pass the environment object
    }
}
