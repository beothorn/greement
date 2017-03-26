module Phase.GamePhases exposing(GamePhases(
    Setup
    ,PlayersChoosingTiles
    ,CollectProfits
    ,PlayerTurn
    ,PayDebts
    ,EventsDraw
 ))

type GamePhases =
    Setup
    | PlayersChoosingTiles
    | CollectProfits
    | PlayerTurn
    | PayDebts
    | EventsDraw