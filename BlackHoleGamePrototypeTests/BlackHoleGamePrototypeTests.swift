import XCTest
@testable import BlackHoleGamePrototype

class BlackHoleGamePrototypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTriangularArray() {
        var array = TriangularArray(rowCount: 6, defaultValue: 0)
        XCTAssertNil(array[0, 1])
        XCTAssertEqual(array[0, 0], 0)
        XCTAssertNil(array[6, 0])
        array[0, 0] = 10
        XCTAssertEqual(array[0, 0], 10)
    }
    
    func testAdjacentElementsAndIndices() {
        let array: TriangularArray = [
                        [-1],
                      [0,  1],
                    [2,  3,   4],
                 [5,   6,   7,   8],
               [9,  10,  11,  12,  13],
            [14,  15,  16,  17,  18,  19]
        ]
        var adjacentIndices = array.adjacentIndices(forRow: 0, index: 0)
        XCTAssertTrue(adjacentIndices.allSatisfy({ (tuple) -> Bool in
            [(1, 0), (1, 1)].contains(where: { $0.0 == tuple.0 && $0.1 == tuple.1 })
        }))
        XCTAssertEqual(adjacentIndices.count, 2)
        
        var adjacentElements = array.adjacentElements(forRow: 0, index: 0)
        XCTAssertEqual(Set(adjacentElements), [0, 1])
        
        adjacentIndices = array.adjacentIndices(forRow: 3, index: 1)
        XCTAssertTrue(adjacentIndices.allSatisfy({ (tuple) -> Bool in
            [(3, 0), (3, 2), (2, 0), (2, 1), (4, 1), (4, 2)]
                .contains(where: { $0.0 == tuple.0 && $0.1 == tuple.1 })
        }))
        XCTAssertEqual(adjacentIndices.count, 6)
        
        adjacentElements = array.adjacentElements(forRow: 3, index: 1)
        XCTAssertEqual(Set(adjacentElements), [2, 3, 5, 7, 10, 11])
    }

    func testGameCanMakeMove() {
        let game = Game()
        XCTAssertTrue(game.canMakeMove(row: 0, index: 0))
        XCTAssertFalse(game.canMakeMove(row: 0 , index: 1))
        XCTAssertTrue(game.canMakeMove(row: 1, index: 0))
        XCTAssertTrue(game.makeMove(row: 1, index: 0))
        XCTAssertFalse(game.canMakeMove(row: 1, index: 0))
    }

    func testGameMakeMove() {
        let game = Game()
        XCTAssertEqual(game.board[0, 0]!, .empty)
        XCTAssertEqual(game.currentNumber, 1)
        XCTAssertEqual(game.currentTurn, .red)
        game.makeMove(row: 0, index: 0)
        XCTAssertEqual(game.board[0, 0]!, .red(number: 1))
        XCTAssertEqual(game.currentNumber, 1)
        XCTAssertEqual(game.currentTurn, .blue)
        game.makeMove(row: 1, index: 0)
        XCTAssertEqual(game.board[1, 0]!, .blue(number: 1))
        XCTAssertEqual(game.currentNumber, 2)
        XCTAssertEqual(game.currentTurn, .red)
    }
    
    func testCheckWinRedWins() {
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
        XCTAssertEqual(game.checkWin(), .redWins)
    }
    
    func testCheckWinBlueWins() {
        let board: TriangularArray<Tile> = [
            [.red(number: 1)],
            [.red(number: 2), .red(number: 3)],
            [.red(number: 5), .red(number: 4), .red(number: 6)],
            [.blue(number: 5), .blue(number: 6), .blue(number: 1), .red(number: 7)],
            [.blue(number: 7), .red(number: 8), .blue(number: 2), .blue(number: 3), .red(number: 8)],
            [.blue(number: 9), .red(number: 10), .empty, .blue(number: 4), .red(number: 10), .red(number: 9)],
            ]
        let game = Game()
        game.board = board
        XCTAssertEqual(game.checkWin(), .blueWins)
    }
    
    func testCheckWinUndecided() {
        let board: TriangularArray<Tile> = [
            [.red(number: 1)],
            [.red(number: 2), .red(number: 3)],
            [.red(number: 5), .red(number: 4), .red(number: 6)],
            [.blue(number: 5), .blue(number: 6), .blue(number: 1), .red(number: 7)],
            [.blue(number: 7), .red(number: 8), .blue(number: 2), .blue(number: 3), .red(number: 8)],
            [.blue(number: 9), .red(number: 10), .empty, .blue(number: 4), .empty, .red(number: 9)],
            ]
        let game = Game()
        game.board = board
        XCTAssertEqual(game.checkWin(), .undecided)
    }
    
}
