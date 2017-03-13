module CommonValues exposing (..)

import Matrix exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel exposing (..) 
import Dict exposing (..)
import GameValues exposing (..)

type alias Model = {
    state : GamePhases
    ,players : List Player
    ,board : Matrix LandTile
    ,values : Dict String Int
    ,turnCounter : Int
    ,problems : List String
    ,setupModel : SetupModel
    ,choosingFirstTilesModel : ChoosingFirstTilesModel
    ,collectProfitsModel : CollectProfitsModel
    ,playerTurnModel : PlayerTurnModel
}

type Msg = 
    NoOp
    | SetupMsg SetupEvent
    | ChoosingFirstTilesMsg ChoosingFirstTilesEvent
    | CollectProfitsMsg CollectProfitsEvent
    | PlayerTurnMsg PlayerTurnEvent