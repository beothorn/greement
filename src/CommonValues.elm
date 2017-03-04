module CommonValues exposing (..)

import Matrix exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Dict exposing (..)

noOwner : String
noOwner = ""

type Land = 
    Empty 
    | Crops 
    | GoldMine 
    | Lake 
    | Mountain 
    | Hidden

type alias LandTile ={ 
    landType : Land
    , owner : String
    , facingUp : Bool
}  

type GamePhases =
    Setup
    | PlayersChoosingTiles
    | MakingFirstLoans
    | PlayerTurn
    | PayDebts
    | CollectProfits
    | EventsDraw

type alias PlayerData = {
    name : String,
    money : Int,
    loan : Int
}

type alias Model = {
    state : GamePhases
    ,players : List String
    ,board : Matrix LandTile
    ,values : Dict String Int
    ,problems : List String
    ,choosingFirstTilesModel : ChoosingFirstTilesModel
    ,makingFirstLoansModel : MakingFirstLoansModel
    ,setupModel : SetupModel
}

type Msg = 
    NoOp
    | SetupMsg SetupEvent
    | ChoosingFirstTilesMsg ChoosingFirstTilesEvent
    | MakingFirstLoansMsg MakingFirstLoansEvent