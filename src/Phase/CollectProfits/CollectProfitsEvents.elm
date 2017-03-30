module Phase.CollectProfits.CollectProfitsEvents exposing (
    startCollectProfits
    ,startTurn
 )

import Phase.CollectProfits.CollectProfitsModel exposing (..)
import Msg exposing (..)
import Player exposing (..)

startCollectProfits : List Player -> Msg
startCollectProfits players = CollectProfitsMsg <| Start players

startTurn : Msg
startTurn = CollectProfitsMsg StartTurn