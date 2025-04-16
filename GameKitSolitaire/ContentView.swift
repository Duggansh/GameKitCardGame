import SwiftUI
import GameKit

struct ContentView: View {
    
    @State private var isAuthenticated = false // Track authentication status
    
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
                    
                    NavigationLink(destination: TicTacToeView().environmentObject(TicTacToeGame())) {
                        Text("Play Tic Tac Toe")
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
                    
                    NavigationLink(destination: Crazy8View().environmentObject(Crazy8Game(numPlayers: 4))) {
                        Text("Play Crazy 8's")
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
        .onAppear {
            authenticatePlayer()
        }
    }

    // Authenticate the player with GameKit
    func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { (viewController, error) in
            if let vc = viewController {
                // If authentication requires presenting a view controller, show it
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let rootVC = windowScene.windows.first?.rootViewController {
                        rootVC.present(vc, animated: true, completion: nil)
                    }
                }
            } else if GKLocalPlayer.local.isAuthenticated {
                // Player is authenticated, ready to use Game Center features
                self.isAuthenticated = true
                print("Player is authenticated")
            } else {
                // Handle authentication failure
                self.isAuthenticated = false
                print("Player authentication failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WarGame())  // Add your environment objects for testing
            .environmentObject(TicTacToeGame())  // Add environment objects for TicTacToe
            .environmentObject(Crazy8Game(numPlayers: 4))  // Add environment object for Crazy 8
    }
}
