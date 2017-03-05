module Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

import Matrix exposing (..)
import GameValues exposing (..)

type alias ChoosingFirstTilesModel = {
    lastSelectedTile : (Int,Int)
    ,playerChoosingTile : Player
    ,playersLeftChoosingTile : List Player
}

type ChoosingFirstTilesEvent = 
    Start
    | OnTileClick Location

initialValue : ChoosingFirstTilesModel
initialValue = ChoosingFirstTilesModel (-1,-1) noPlayer []