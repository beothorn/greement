module CommonValues exposing (..)

type GameState =
    Setup
    | PlayesChoosingTiles


type alias Model = {
    state : GameState,
    playerInput : String,
    players : List String
}

type Msg = 
    AddPlayer
    | UpdatePlayerName String
    | FinishAddingPlayers