module CommonValues exposing (..)

type GamePhases =
    Setup
    | PlayesChoosingTiles
    | MakingLoans
    | PlayerTurn
    | PayDebts
    | CollectProfits
    | EventsDraw


type alias Model = {
    state : GamePhases,
    playerInput : String,
    players : List String
}

type Msg = 
    AddPlayer
    | UpdatePlayerName String
    | FinishAddingPlayers