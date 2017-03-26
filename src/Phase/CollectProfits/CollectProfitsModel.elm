module Phase.CollectProfits.CollectProfitsModel exposing (..)

import Player exposing (..)

type alias CollectProfitsModel = {
    currentPlayerProfit : Int
    ,playersLeft : List Player
}

type CollectProfitsEvent = 
    Start (List Player)
    | StartTurn

initialValue : CollectProfitsModel
initialValue = CollectProfitsModel 0 []