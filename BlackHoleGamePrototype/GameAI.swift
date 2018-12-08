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
    
}
