module Msg exposing (Msg(
    NoOp
    ,SetupMsg
    ,ChoosingFirstTilesMsg
    ,CollectProfitsMsg
    ,PlayerTurnMsg
 ))

import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel exposing (..) 

type Msg = 
    NoOp
    | SetupMsg SetupEvent
    | ChoosingFirstTilesMsg ChoosingFirstTilesEvent
    | CollectProfitsMsg CollectProfitsEvent
    | PlayerTurnMsg PlayerTurnEvent