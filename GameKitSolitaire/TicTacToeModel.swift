//
//  TicTacToeModel.swift
//  GameKitSolitaire
//
//  Created by Shane M. Duggan on 4/10/25.
//

import SwiftUI

class TicTacToeGame: ObservableObject{
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var xTurn = true
    @Published var gameEnd = false
    @Published var infoText: String = "Player 1's Turn!"

    func checkWin(player: Int) -> (Bool,String) {
        // Check rows
        for row in 0..<3 {
            if board[row][0] != "" && board[row][0] == board[row][1] && board[row][1] == board[row][2] {
                return (true,"Player \(player) wins on row \(row + 1)!")
            }
        }

        // Check columns
        for col in 0..<3 {
            if board[0][col] != "" && board[0][col] == board[1][col] && board[1][col] == board[2][col] {
                return (true,"Player \(player) wins on column \(col + 1)!")
            }
        }

        // Check diagonals
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return (true,"Player \(player) wins on the main diagonal!")
        }

        if board[0][2] != "" && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return (true,"Player \(player) wins on the anti-diagonal!")
        }
        
        let isBoardFull = !board.flatMap { $0 }.contains("")
        
        if isBoardFull{
            return(true,"Tie Game! No Winners")
        }
        
        if player == 1{
            return (false,"Player \(player + 1)'s Turn!")
        } else {
            return (false,"Player \(player - 1)'s Turn!")
        }
    }

    
    func resetGame(){
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        infoText = "Player 1's Turn!"
        xTurn = true
        gameEnd = false
    }
    
}
