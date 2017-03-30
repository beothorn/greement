module Board.ValueTable exposing (
    startingValueTable
    ,getPriceFor
    ,getProfitFor
    ,landKey
    ,goldMineKey
    ,cropProfitKey
    ,goldMineProfitKey
    ,distanceTaxKey
 )

import Dict exposing (..)
import Land exposing (..)
import Common.Common exposing (..)

landKey : String
landKey = "Land"

goldMineKey : String
goldMineKey = "Gold mine"

cropProfitKey : String
cropProfitKey = "Crop profit"

goldMineProfitKey : String
goldMineProfitKey = "Gold mine profit"

distanceTaxKey : String
distanceTaxKey = "Distance tax"

startingValueTable : Dict String Int
startingValueTable = Dict.fromList [
        (  landKey,2)
        , ("Seed",2)
        , (cropProfitKey,3)
        , (goldMineKey,5)
        , (goldMineProfitKey,4)
        , ("Lake multiplier",1)
        , ("Mountain multiplier",1)
        , (distanceTaxKey,4)
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

getProfitFor : Land -> Dict String Int -> Int
getProfitFor land valueTable = 
    case land of
        GoldMine -> getFromDictOrCry goldMineProfitKey valueTable
        Crops -> getFromDictOrCry cropProfitKey valueTable
        otherwise -> 0