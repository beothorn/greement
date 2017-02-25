module Board.Game exposing (..)

import Board.Lands exposing (..)
import Random
import Matrix exposing (..)

makeBoard : GameConfig -> List (List LandTile)
makeBoard gameConfig =
    let
        goldMinePositions = makeRandomTuples gameConfig.size gameConfig.goldMineCount (Random.initialSeed 1000)
        lakePositions = makeRandomTuplesExcluding gameConfig.size gameConfig.lakeCount (Random.initialSeed 1001) goldMinePositions
        mountainsPositions = makeRandomTuplesExcluding gameConfig.size gameConfig.mountainCount (Random.initialSeed 1002) lakePositions
    in
        toList <| matrix gameConfig.size gameConfig.size <| getLand goldMinePositions lakePositions mountainsPositions

type alias GameConfig = {
    size : Int,
    goldMineCount : Int,
    lakeCount : Int,
    mountainCount : Int
}

randomTuple : Int -> Random.Seed -> ((Int, Int), Random.Seed)
randomTuple max seed = 
    let 
        rgen = Random.int 0 max
        (x, firstSeed) = Random.step rgen seed
        (y, secondSeed) = Random.step rgen firstSeed
    in
    ((x, y), secondSeed)

makeRandomTuplesExcluding : Int -> Int -> Random.Seed -> List (Int, Int) -> List (Int, Int)
makeRandomTuplesExcluding max qntd seed excluding = 
    let
        (rtuple, rseed) = randomTuple max seed
    in
    case qntd of 
        0 -> []
        _ -> if List.member rtuple excluding 
                then
                    makeRandomTuplesExcluding  max qntd rseed excluding 
                else 
                    rtuple :: makeRandomTuplesExcluding max (qntd - 1) rseed (rtuple :: excluding)

makeRandomTuples : Int -> Int -> Random.Seed -> List (Int, Int)
makeRandomTuples max qntd seed = makeRandomTuplesExcluding max qntd seed [] 

getLand: List (Int, Int) -> List (Int, Int) ->  List (Int, Int) -> Location ->LandTile
getLand goldMinePositions lakePositions mountainsPositions location = 
    if List.member location goldMinePositions then
        {landType = GoldMine, owner = "Gold"}
    else if List.member location lakePositions then
        {landType = Lake, owner = "Lake"}
    else if List.member location mountainsPositions then
        {landType = Mountain, owner = "Mountain"}
    else
        {landType = Empty, owner = "NOONE"}