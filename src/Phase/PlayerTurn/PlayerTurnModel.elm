module Phase.PlayerTurn.PlayerTurnModel exposing (..)

import GameValues exposing (..)

type alias PlayerTurnModel = {
    playersLeft : List Player
}

type PlayerTurnEvent = 
    Start (List Player)
    | EndTurn

initialValue : PlayerTurnModel
initialValue = PlayerTurnModel []