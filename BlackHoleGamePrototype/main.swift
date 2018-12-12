import Foundation

func testGameMakeMove() {
    let game = Game()
    game.makeMove(row: 1, index: 0)
    game.makeMove(row: 3, index: 2)
    game.makeMove(row: 2, index: 1)
    game.makeMove(row: 5, index: 3)
    print(game)
}

func gameWithAIFixedDepth() {
    let game = Game()

    while (game.checkWin() == .undecided) {
        print(game)
        if (game.currentTurn == .red) {
            var row = -1
            var index = -1
            repeat {
                let coordinates = readLine()!.split(separator: " ")
                row = Int(coordinates[0])!
                index = Int(coordinates[1])!
            } while (!game.makeMove(row: row, index: index))
        } else {
            let ai = GameAI(game: Game(copyOf: game), myColor: .blue)
            let (row, index) = ai.getNextMove()
            game.makeMove(row: row, index: index)
        }
    }
    print(game)
    print(game.checkWin())
}

func testCheckWin() {
    let board: TriangularArray<Tile> = [
        [.red(number: 1)],
        [.red(number: 2), .red(number: 3)],
        [.red(number: 5), .red(number: 4), .red(number: 6)],
        [.blue(number: 5), .blue(number: 6), .blue(number: 1), .red(number: 7)],
        [.blue(number: 7), .blue(number: 8), .blue(number: 2), .blue(number: 3), .red(number: 8)],
        [.blue(number: 9), .blue(number: 10), .empty, .blue(number: 4), .red(number: 10), .red(number: 9)],
    ]
    let game = Game()
    game.board = board
    print(game.checkWin())
}
    print(game)
}
