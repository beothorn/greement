module Board.Game exposing (..)

import Board.Lands exposing (..)
import Random

--type Land = Empty | Crops | GoldMine | Lake | Mountain 
type alias GameConfig = {
    size : Int,
    landCount : Int,
    goldMineCount : Int,
    lakeCount : Int,
    mountainCount : Int
}

distributeLand : Land -> Int -> List (List LandTile)
distributeLand land qntd land =  List.length

makeBoard : GameConfig -> List String -> List (List LandTile)
makeBoard gameConfig names = List.repeat gameConfig.size (List.repeat gameConfig.size {landType = Empty, owner = "NOONE"})