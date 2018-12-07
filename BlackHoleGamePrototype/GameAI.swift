class GameAI {
    var game: Game
    
    let myColor: PlayerSide
    
    init(game: Game, myColor: PlayerSide) {
        self.game = game
        self.myColor = myColor
    }
}
