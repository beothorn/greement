module Board.ValueTable exposing (
    startingValueTable
    ,getPriceFor
 )

import Dict exposing (..)
import Land exposing (..)
import Common.Common exposing (..)

landKey : String
landKey = "Land"

goldMineKey : String
goldMineKey = "Gold mine"

startingValueTable : Dict String Int
startingValueTable = Dict.fromList [
        (  landKey,2)
        , ("Seed",2)
        , ("Crop profit",3)
        , (goldMineKey,5)
        , ("Gold mine profit",4)
        , ("Lake multiplier",1)
        , ("Mountain multiplier",1)
        , ("Distance tax",4)
        , ("Loan multiplier",2)
        , ("Cattle",5)
        , ("Cattle profit",6)
        , ("Action card", 15)
    ]

getPriceFor : Land -> Dict String Int -> Int
getPriceFor land valueTable = 
    case land of
        Empty -> getFromDictOrCry landKey valueTable
        GoldMine -> getFromDictOrCry goldMineKey valueTable
        otherwise -> 0