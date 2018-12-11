class GameAI {
    var game: Game
    
    let myColor: PlayerSide
    
    init(game: Game, myColor: PlayerSide) {
        self.game = game
        self.myColor = myColor
    }
    
    func evaluateHeuristics() -> Int {
        let result = game.checkWin()
        if result == .draw {
            return 100
        } else if result == .undecided {
            return 0
        } else if (result == .blueWins && myColor == .blue) || (result == .redWins && myColor == .red) {
            return 10000
        } else {
            return -10000
        }
    }
    
    func getAvailableMoves() -> [(row: Int, index: Int)] {
        var moves = [(row: Int, index: Int)]()
        for i in 0..<game.boardSize {
            for j in 0..<(i + 1) {
                if game.canMakeMove(row: i, index: j) {
                    moves.append((i, j))
                }
            }
        }
        return moves
    }
    
    private func minimax(depth: Int, color: PlayerSide) -> (score: Int, row: Int, index: Int) {
        var bestScore = color == myColor ? Int.min : Int.max
        var currentScore: Int
        var bestMove: (row: Int, index: Int)?
        if game.checkWin() != .undecided {
            bestScore = evaluateHeuristics()
        } else {
            for move in getAvailableMoves() {
                game.makeMove(row: move.row, index: move.index)
                if color == myColor {
                    currentScore = minimax(depth: depth - 1, color: game.currentTurn).score
                    if currentScore > bestScore {
                        bestScore = currentScore
                        bestMove = move
                    }
                } else {
                    currentScore = minimax(depth: depth - 1, color: game.currentTurn).score
                    if currentScore < bestScore {
                        bestScore = currentScore
                        bestMove = move
                    }
                }
               
                undoMove(row: move.row, index: move.index)
            }
        }
        return (bestScore, bestMove?.row ?? 0, bestMove?.index ?? 0)
    }
    
    func getNextMove() -> (row: Int, index: Int) {
        let result = minimax(depth: 6, color: myColor)
        return (result.row, result.index)
    }
    
    func undoMove(row: Int, index: Int) {
        game.board[row, index] = .empty
        if game.currentTurn == .red {
            game.currentTurn = .blue
            game.currentNumber -= 1
        } else {
            game.currentTurn = .red
        }
    }
}
