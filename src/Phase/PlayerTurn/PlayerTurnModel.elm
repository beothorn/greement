module Phase.PlayerTurn.PlayerTurnModel exposing (..)

import GameValues exposing (..)

type alias PlayerTurnModel = {
    lastSelectedTile : (Int,Int)
    ,currentPlayer : Player
    ,playersLeftToPlay : List Player
}

type PlayerTurnEvent = 
    Start

initialValue : PlayerTurnModel
initialValue = PlayerTurnModel (-1,-1) noPlayer []