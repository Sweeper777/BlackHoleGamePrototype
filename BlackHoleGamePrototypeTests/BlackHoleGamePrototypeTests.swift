import XCTest
@testable import BlackHoleGamePrototype

class BlackHoleGamePrototypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
