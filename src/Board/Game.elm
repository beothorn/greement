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


randomTuple : Int -> Int -> Random.Seed -> ((Int, Int), Random.Seed)
randomTuple min max seed = 
    let 
        rgen = Random.int min max
        (x, firstSeed) = Random.step rgen seed
        (y, secondSeed) = Random.step rgen firstSeed
    in
    ((x, y), secondSeed)

makeRandomTuplesExcluding : Int -> Int -> Int -> Random.Seed -> List (Int, Int) -> List (Int, Int)
makeRandomTuplesExcluding min max qntd seed excluding = 
    let
        (rtuple, rseed) = randomTuple min max seed
    in
    case qntd of 
        0 -> []
        _ -> if List.member rtuple excluding 
                then
                    makeRandomTuplesExcluding min max qntd rseed excluding 
                else 
                    rtuple :: makeRandomTuplesExcluding min max (qntd - 1) rseed (rtuple :: excluding)

makeRandomTuples : Int -> Int -> Int -> Random.Seed -> List (Int, Int)
makeRandomTuples min max qntd seed = makeRandomTuplesExcluding min max qntd seed [] 

makeBoard : GameConfig -> List String -> List (List LandTile)
makeBoard gameConfig names = List.repeat gameConfig.size (List.repeat gameConfig.size {landType = Empty, owner = "NOONE"})