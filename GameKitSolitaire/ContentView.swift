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
        NavigationStack {
            ZStack {
                // Background Image
                Image("title_screen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Overlay to darken the background image slightly for better text visibility
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    // Title Text
                    Text("Card Games")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .padding(.top, 50) // Add some padding from the top

                    Spacer()
                    
                    // Play War Button
                    NavigationLink(destination: WarView().environmentObject(WarGame())) {
                        Text("Play War")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.black]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .padding(.horizontal, 30)
                    }
                    // Play Solitaire Button
                    NavigationLink(destination: SolitaireView(cardClicked: false, selectedCard: nil).environmentObject(SolitaireGame())) {
                        Text("Play Solitaire")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.black]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .padding(.horizontal, 30)
                    }
                    NavigationLink(destination: TicTacToeView().environmentObject(TicTacToeGame())) {
                        Text("Play Tic Tic Toe")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.red, Color.black]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .padding(.horizontal, 30)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
             // Initialize and pass the environment object
    }
}
