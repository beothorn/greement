module Phase.PlayerTurn.PlayerTurnModel exposing (..)

import Player exposing (..)
import Matrix exposing (..)

type alias PlayerTurnModel = {
    playersLeft : List Player
    ,isBuyingLand : Bool
    ,landLocationBeingBought : Location
}

type PlayerTurnEvent = 
    Start (List Player)
    | BuyClicked
    | DontBuyClicked
    | TileClicked Location
    | EndTurn

initialValue : PlayerTurnModel
initialValue = PlayerTurnModel [] False (-1, -1)