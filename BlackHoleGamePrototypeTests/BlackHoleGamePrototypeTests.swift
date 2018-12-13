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

}
