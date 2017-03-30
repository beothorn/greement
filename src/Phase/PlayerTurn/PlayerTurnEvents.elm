module Phase.PlayerTurn.PlayerTurnEvents exposing (
    startPlayerTurn
    ,buyClicked
    ,dontBuyClicked
    ,tileClicked
    ,endTurn
 )

import Msg exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Player exposing (..)
import Matrix exposing (..)

startPlayerTurn : List Player -> Msg
startPlayerTurn players = PlayerTurnMsg <| Start players

buyClicked : Msg
buyClicked = PlayerTurnMsg BuyClicked

dontBuyClicked : Msg
dontBuyClicked = PlayerTurnMsg DontBuyClicked

tileClicked : Location -> Msg
tileClicked tileLocation = PlayerTurnMsg <| TileClicked tileLocation

endTurn : Msg
endTurn = PlayerTurnMsg EndTurn