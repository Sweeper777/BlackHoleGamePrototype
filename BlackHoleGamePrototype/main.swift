import Foundation

//let game = Game()
//game.makeMove(row: 1, index: 0)
//game.makeMove(row: 3, index: 2)
//game.makeMove(row: 2, index: 1)
//game.makeMove(row: 5, index: 3)
//print(game)

let game = Game()
while (game.checkWin() == .undecided) {
    print(game.currentTurn)
    print(game)
    var row = -1
    var index = -1
    repeat {
        let coordinates = readLine()!.split(separator: " ")
        row = Int(coordinates[0])!
        index = Int(coordinates[1])!
    } while (!game.makeMove(row: row, index: index))
}
