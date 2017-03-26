module Model exposing (Model)

import Matrix exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel exposing (..) 
import Dict exposing (..)
import Player exposing (..)
import Phase.GamePhases exposing (..)
import LandTile exposing (..)

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