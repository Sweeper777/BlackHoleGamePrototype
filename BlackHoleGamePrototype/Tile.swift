enum Tile {
    case empty
    case red(number: Int)
    case blue(number: Int)
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
