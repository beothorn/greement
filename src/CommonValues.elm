module CommonValues exposing (..)

import Matrix exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.Setup.SetupModel exposing (..)

noOwner : String
noOwner = "NONE"

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
    | MakingLoans
    | PlayerTurn
    | PayDebts
    | CollectProfits
    | EventsDraw

type alias Model = {
    state : GamePhases
    ,players : List String
    ,board : Matrix LandTile
    ,values : List (String, Int, String) --Name value suffix
    ,choosingFirstTilesModel : ChoosingFirstTilesModel
    ,setupModel : SetupModel
}

type Msg = 
    SetupMsg SetupEvent
    | ChoosingFirstTilesMsg ChoosingFirstTilesEvent