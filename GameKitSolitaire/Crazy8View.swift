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
                ForEach(1..<game.playerHands.count, id: \.self) { i in
                    Text("Bot \(i): \(game.playerHands[i].count) cards")
                        .foregroundColor(.yellow)
                }
                Spacer()
                Text(game.message)
                    .foregroundColor(.yellow)
                HStack {
                    Button(action: {
                        game.drawCardForPlayer(playerIndex: game.playerTurn)
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
                .defaultScrollAnchor(.center)
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
    }
}

struct Crazy8View_Previews: PreviewProvider {
    static var previews: some View {
        Crazy8View().environmentObject(Crazy8Game(numPlayers: 4))
    }
}
