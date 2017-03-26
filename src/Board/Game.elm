module Board.Game exposing (
    makeBoard
    ,GameConfig
    ,getPriceFor
    ,updatePlayerLoan
    ,updatePlayerMoney
 )

import Random
import Player exposing (..)
import Land exposing (..)
import LandTile exposing (..)
import Dict exposing (..)
import Matrix exposing (..)
import Common.Common exposing (..)
getPriceFor : Land -> Dict String Int -> Int
getPriceFor land valueTable = 
    case land of
        Empty -> Dict.get "Land" valueTable |> unpackOrCry "'Land' should be on value table"
        Crops  -> 0
        GoldMine -> Dict.get "Gold mine" valueTable |> unpackOrCry "'Gold mine' should be on value table"
        Lake -> 0
        Mountain -> 0
        Hidden -> 0

updatePlayerLoan : String -> Int -> List Player -> List Player
updatePlayerLoan playerName newLoan oldPlayers = 
    List.map (\p -> if p.name == playerName then {p| loan = newLoan} else p ) oldPlayers

updatePlayerMoney : String -> Int -> List Player -> List Player
updatePlayerMoney playerName newMoney oldPlayers = 
    List.map (\p -> if p.name == playerName then {p| money = newMoney} else p ) oldPlayers

makeBoard : GameConfig -> Matrix LandTile
makeBoard gameConfig =
    let
        goldMinePositions = makeRandomTuples gameConfig.size gameConfig.goldMineCount (Random.initialSeed 1000)
        lakePositions = makeRandomTuplesExcluding gameConfig.size gameConfig.lakeCount (Random.initialSeed 1001) goldMinePositions
        mountainsPositions = makeRandomTuplesExcluding gameConfig.size gameConfig.mountainCount (Random.initialSeed 1002) lakePositions
    in
        matrix gameConfig.size gameConfig.size <| getLand goldMinePositions lakePositions mountainsPositions

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
    let
      noOwner = noPlayer
    in
        if List.member location goldMinePositions then
            {landType = GoldMine, owner = noOwner, facingUp = False}
        else if List.member location lakePositions then
            {landType = Lake, owner = noOwner, facingUp = False}
        else if List.member location mountainsPositions then
            {landType = Mountain, owner = noOwner, facingUp = False}
        else
            {landType = Empty, owner = noOwner, facingUp = False}