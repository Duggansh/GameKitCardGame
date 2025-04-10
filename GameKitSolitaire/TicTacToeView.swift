import SwiftUI

struct TicTacToeView: View {
    @EnvironmentObject var ticTacToe: TicTacToeGame
    @Environment(\.dismiss) private var dismiss // Use dismiss for NavigationStack
    
    func handleTap(row: Int, col: Int) {
        if ticTacToe.board[row][col] == "" && !ticTacToe.gameEnd {
            if ticTacToe.xTurn {
                ticTacToe.board[row][col] = "X"
                (ticTacToe.gameEnd, ticTacToe.infoText) = ticTacToe.checkWin(player: 1)
            } else {
                ticTacToe.board[row][col] = "O"
                (ticTacToe.gameEnd, ticTacToe.infoText) = ticTacToe.checkWin(player: 2)
            }
            ticTacToe.xTurn.toggle()
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Text(ticTacToe.infoText)
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(.top, 20)
                
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(0..<3, id: \.self) { col in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.red, lineWidth: 3)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                                    .frame(width: 90, height: 90)
                                
                                Text(ticTacToe.board[row][col])
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(ticTacToe.board[row][col] == "X" ? .red : .white)
                            }
                            .onTapGesture {
                                handleTap(row: row, col: col)
                            }
                        }
                    }
                }
                
                Group {
                    if ticTacToe.gameEnd {
                        Button(action: {
                            ticTacToe.board = Array(repeating: Array(repeating: "", count: 3), count: 3)
                            ticTacToe.infoText = "Player 1's Turn!"
                            ticTacToe.xTurn = true
                            ticTacToe.gameEnd = false
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
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }.navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.backward.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                            Text("Back")
                                .foregroundColor(.red)
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.black)
                        .cornerRadius(12)
                        .shadow(color: .red.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                }
            }

    }
    
} 


struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView().environmentObject(TicTacToeGame())
    }
}
