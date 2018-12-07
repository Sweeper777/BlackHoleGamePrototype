import Foundation

class Game {
    var board: TriangularArray<Tile>
    var currentTurn = PlayerSide.red
    var currentNumber = 1
    let boardSize = 6
    
    init() {
        board = TriangularArray(rowCount: boardSize, defaultValue: .empty)
    }
    
    init(copyOf game: Game) {
        board = game.board
        currentTurn = game.currentTurn
        currentNumber = game.currentNumber
    }
    
    func canMakeMove(row: Int, index: Int) -> Bool {
        switch board[row, index] {
        case .some(.empty):
            return true
        default:
            return false
        }
    }
    
}
