module GameValues exposing (..)

noPlayer : Player
noPlayer = Player "" 0 0

type Land = 
    Empty 
    | Crops 
    | GoldMine 
    | Lake 
    | Mountain 
    | Hidden

type alias LandTile ={ 
    landType : Land
    , owner : Player
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

type alias Player = {
    name : String,
    money : Int,
    loan : Int
}