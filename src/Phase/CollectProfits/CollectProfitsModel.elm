module Phase.CollectProfits.CollectProfitsModel exposing (..)

import GameValues exposing (..)

type alias CollectProfitsModel = {
    lastSelectedTile : (Int,Int)
    ,currentPlayer : Player
    ,playersLeftToPlay : List Player
}

type CollectProfitsEvent = 
    Start

initialValue : CollectProfitsModel
initialValue = CollectProfitsModel (-1,-1) noPlayer []