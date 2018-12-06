enum Tile {
    case empty
    case red(number: Int)
    case blue(number: Int)
}

extension TriangularArray where T == Tile {
    var emptyCount: Int {
        return self.filter {
            if case .empty = $0 {
                return true
            }
            return false
        }.count
    }
    
}

enum PlayerSide {
    case red
    case blue
}

enum GameResult {
    case redWins
    case blueWins
    case draw
    case undecided
}
