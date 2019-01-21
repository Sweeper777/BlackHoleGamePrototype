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

func searchDepth(forTurn turn: Int) -> Int {
    if turn < 10 {
        return 3
    }
    if turn < 14 {
        return 4
    }
    return 6
}

func gameWithAIVariableDepth() {
    let game = Game()
    var turn = 0
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
            let (row, index) = ai.getNextMove(searchDepth: searchDepth(forTurn: turn))
            game.makeMove(row: row, index: index)
        }
        turn += 1
    }
    print(game)
    print(game.checkWin())
}

func twoAIs(boardSize: Int = 6) {
    let game = Game(boardSize: boardSize)
    var turn = 0
    while (game.checkWin() == .undecided) {
        print(game)
        let ai = GameAI(game: Game(copyOf: game), myColor: game.currentTurn)
        let (row, index) = ai.getNextMove(searchDepth: searchDepth(forTurn: turn))
        game.makeMove(row: row, index: index)
        turn += 1
    }
    print(game)
    print(game.checkWin())
}
gameWithAIVariableDepth()
