import SwiftUI

struct Crazy8View: View {
    @EnvironmentObject var game: Crazy8Game
    @State private var selectedCard: Card?
    
    // Helper function to get the image for the card model
    func getCardImage(for card: Card) -> String {
        return "\(card.suit)_\(card.rank)"
    }
    
    var body: some View {
        ZStack {
            Image("felt-background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Discard Pile")
                        .font(.title)
                        .padding()
                    if let topCard = game.discardPile.last {
                        Image(getCardImage(for: topCard))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                    }
                }
                .padding(.horizontal)

                VStack {
                    Text("Your Cards")
                        .font(.headline)
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(game.playerHands[0], id: \.self) { card in
                                Button(action: {
                                    // Handle card selection
                                    selectedCard = card
                                }) {
                                    Image(getCardImage(for: card))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 120)
                                        .padding(2)
                                        .background(selectedCard == card ? Color.blue.opacity(0.5) : Color.clear)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                VStack {
                    if let cardToPlay = selectedCard {
                        Button(action: {
                            // Play the selected card
                            if let playerIndex = game.playerHands.firstIndex(where: { $0.contains(cardToPlay) }) {
                                game.playCard(playerIndex: playerIndex, card: cardToPlay)
                                selectedCard = nil // Reset selection after playing
                            }
                        }) {
                            Text("Play Card")
                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                    }

                    Button(action: {
                        // Draw a card
                        game.drawCardForPlayer(playerIndex: game.playerTurn)
                    }) {
                        Text("Draw Card")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                }
            }
        }
        .padding()
    }
}

struct Crazy8View_Previews: PreviewProvider {
    static var previews: some View {
        Crazy8View().environmentObject(Crazy8Game(numPlayers: 4))
    }
}
