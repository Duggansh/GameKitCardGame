import SwiftUI

struct WarView: View {
    @EnvironmentObject var warGame: WarGame
    @Environment(\.dismiss) private var dismiss // Use dismiss for NavigationStack
    @State private var cardPosition: CGFloat = 0 // Position of the cards (0 = center, negative = top, positive = bottom)
    @State private var isAnimating = false // To track whether the animation is in progress
    @State private var flipComplete = false // To track whether the card flip is complete
    @State private var moveComplete = false // To track whether the movement animation is complete

    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Image(warGame.playerTwoDeck.cardPile.count > 0 ? "back07" : "").resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                    Text("Cards left: \(warGame.playerTwoDeck.cardPile.count)").foregroundColor(.yellow)
                }
                
                // Player 2 Card: Flip animation and move
                Image(warGame.p2Card == nil || !flipComplete ? "" : warGame.p2Card!.model) // Show image after flip
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .offset(y: cardPosition) // Move card based on position state
                    .animation(isAnimating && !moveComplete ? .easeInOut(duration: 1) : nil, value: cardPosition) // Apply movement animation
                    .zIndex(0)
                
                Text(warGame.centerString).foregroundColor(.yellow)
                    .zIndex(1)
                
                // Player 1 Card: Flip animation and move
                Image(warGame.p1Card == nil || !flipComplete ? "" : warGame.p1Card!.model) // Show image after flip
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .offset(y: cardPosition) // Move card based on position state
                    .animation(isAnimating && !moveComplete ? .easeInOut(duration: 1) : nil, value: cardPosition) // Apply movement animation
                    .zIndex(0)
                
                HStack {
                    Text("Cards left: \(warGame.playerOneDeck.cardPile.count)").foregroundColor(.yellow)
                    Image(warGame.playerOneDeck.cardPile.count > 0 ? "back05" : "").resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                }
                .onTapGesture {
                    if(!warGame.gameOver){
                        if !isAnimating { // Only allow taps when not animating
                            if warGame.playerOneDeck.cardPile.count > 0 {
                                warGame.p1Card = warGame.playerOneDeck.draw()!
                                if warGame.playerTwoDeck.cardPile.count > 0 {
                                    warGame.p2Card = warGame.playerTwoDeck.draw()!
                                    let outcome = warGame.compareCards()
                                    
                                    // Immediately show the image and start the flip
                                    flipComplete = false
                                    isAnimating = true
                                    
                                    // Wait for a very brief moment (to let the state update) before flipping
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        flipComplete = true // Immediately set flipComplete to true after a brief delay
                                        
                                        // Now the cards are flipped and updated, proceed to move them
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            // Based on outcome, move the cards
                                            if outcome == .p1 {
                                                cardPosition = 100 // Move to bottom if Player 1 wins
                                            } else if outcome == .p2 {
                                                cardPosition = -100 // Move to top if Player 2 wins
                                            }
                                            
                                            // After the movement, hide the card image and reset position instantly to the center
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                // Set the image to empty (disappear)
                                                
                                                warGame.p1Card = nil
                                                
                                                warGame.p2Card = nil
                                                
                                                
                                                // Reset the position to the center instantly (no animation)
                                                cardPosition = 0
                                                
                                                // End the animation so the cards stay at the top/bottom and disappear
                                                isAnimating = false
                                            }
                                        }
                                    }
                                    
                                    // Update the center string based on the game state
                                    if warGame.playerTwoDeck.cardPile.isEmpty {
                                        warGame.gameOver = true
                                        warGame.centerString = "GAME OVER! You win!"
                                    } else if warGame.playerOneDeck.cardPile.isEmpty {
                                        warGame.gameOver = true
                                        warGame.centerString = "GAME OVER! You lose!"
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Play Again Button (only visible if the game is over)
                if warGame.gameOver {
                    Button(action: {
                        // Reset the game
                        warGame.resetGame() // Implement this method in WarGame to reset the game
                        warGame.gameOver = false
                        warGame.centerString = "Play Again!"
                        cardPosition = 0 // Reset card position to center
                        flipComplete = false
                        isAnimating = false
                        moveComplete = false
                    }) {
                        Text("Play Again")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 50)
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .navigationBarItems(leading:
            Button(action: {
                dismiss() // Use dismiss() method from Environment to pop the view
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill") // Custom back icon
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Back")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        )
    }
}

struct WarView_Previews: PreviewProvider {
    static var previews: some View {
        // Initialize the GameState and pass it via environmentObject
        WarView().environmentObject(WarGame())
    }
}
