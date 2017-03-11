module CommonValues exposing (..)

import Matrix exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)
import Phase.Setup.SetupModel exposing (..)
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
    ,makingFirstLoansModel : MakingFirstLoansModel
}

type Msg = 
    NoOp
    | SetupMsg SetupEvent
    | ChoosingFirstTilesMsg ChoosingFirstTilesEvent
    | MakingFirstLoansMsg MakingFirstLoansEvent