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
    
    @discardableResult
    func makeMove(row: Int, index: Int) -> Bool {
        if board.emptyCount > 1 {
            if case .some(.empty) = board[row, index] {
                switch currentTurn {
                case .red:
                    board[row, index] = .red(number: currentNumber)
                    currentTurn = .blue
                case .blue:
                    board[row, index] = .blue(number: currentNumber)
                    currentTurn = .red
                    currentNumber += 1
                }
                return true
            }
        }
        return false
    }
}
