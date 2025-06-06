import SwiftUI

struct Crazy8View: View {
    @EnvironmentObject var game: Crazy8Game
    @State private var selectedCard: Card?
    @Environment(\.dismiss) private var dismiss // Use dismiss for NavigationStack
    
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
                ForEach(1..<game.playerHands.count, id: \.self) { i in
                    Text("Bot \(i): \(game.playerHands[i].count) cards")
                        .foregroundColor(.yellow)
                }
                Spacer()
                Text(game.message)
                    .foregroundColor(.yellow)
                HStack {
                    Button(action: {
                        if game.playerTurn != 0 {
                            game.message = "It is not your turn!"
                        }
                        else {
                            game.drawCard(playerIndex: game.playerTurn, numCards: 1)
                        }
                    }) {
                        Image("back05").resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                    }
                    Image(game.discardPile.isEmpty ? "" : getCardImage(for: game.discardPile.last!)).resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 120)
                }
                Spacer()
                Group {
                    if game.roundIsOver {
                        Button(action: {
                            game.resetGame()
                        }) {
                            Text("Play Again")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(Color.red)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                    } else {
                        Color.clear.frame(height: 44)
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(game.playerHands[0], id: \.self) { card in
                            Button(action: {
                                selectedCard = card
                            }) {
                                Image(getCardImage(for: card))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 120)
                                    .overlay(
                                        // blue border when selected
                                        selectedCard == card ?
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: 4) : nil
                                    )
                            }
                        }
                    }
                }
                .frame(width: 400.0, height: 100.0, alignment: .center)
                Button(action: {
                    if selectedCard != nil {
                        game.playCard(playerIndex: 0, card: selectedCard!)
                    }
                }) {
                    Text("Play Card")
                        .foregroundStyle(.yellow)
                }
                Spacer()
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

struct Crazy8View_Previews: PreviewProvider {
    static var previews: some View {
        Crazy8View().environmentObject(Crazy8Game(numPlayers: 4))
    }
}

