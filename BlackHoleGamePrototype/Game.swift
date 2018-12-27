import Foundation

class Game {
    var board: TriangularArray<Tile>
    var currentTurn = PlayerSide.red
    var currentNumber = 1
    let boardSize: Int
    
    init(boardSize: Int = 6) {
        self.boardSize = boardSize
        board = TriangularArray(rowCount: boardSize, defaultValue: .empty)
    }
    
    init(copyOf game: Game) {
        board = game.board
        currentTurn = game.currentTurn
        currentNumber = game.currentNumber
        boardSize = game.boardSize
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
    
    func checkWin() -> GameResult {
        if board.emptyCount != 1 {
            return .undecided
        }
        guard let indexOfEmpty = board.indexOfEmpty() else { return .undecided }
        let adjacentTiles = board.adjacentElements(forRow: indexOfEmpty.0, index: indexOfEmpty.1)
        let (redScore, blueScore) = adjacentTiles.reduce((0, 0), {
            result, tile in
            if case .red(let num)  = tile {
                return (result.0 + num, result.1)
            } else if case .blue(let num) = tile {
                return (result.0, result.1 + num)
            }
            return result
        })
        if redScore < blueScore {
            return .redWins
        } else if redScore > blueScore {
            return .blueWins
        } else {
            return .draw
        }
    }
    
    
}

extension Game: CustomStringConvertible {
    var description: String {
        var desc = ""
        for i in 0..<boardSize {
            for _ in 0..<(boardSize - i - 1) {
                desc += " "
            }
            for j in 0..<(i + 1) {
                switch board[i, j]! {
                case .empty:
                    desc += ANSIColors.white + "0 "
                case .red(10):
                    desc += ANSIColors.red + "⒑ "
                case .blue(10):
                    desc += ANSIColors.blue + "⒑ "
                case .red(let num):
                    desc += ANSIColors.red + "\(num) "
                case .blue(let num):
                    desc += ANSIColors.blue + "\(num) "
                }
            }
            desc += "\n"
        }
        return desc
    }
}
