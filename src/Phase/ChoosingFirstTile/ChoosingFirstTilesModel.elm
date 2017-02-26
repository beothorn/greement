module Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

import Matrix exposing (..)

type alias ChoosingFirstTilesModel = {
    lastSelectedTile : (Int,Int)
    ,playerChoosingTile : String
}

type ChoosingFirstTilesEvent = OnTileClick Location

initialValue : ChoosingFirstTilesModel
initialValue = ChoosingFirstTilesModel (-1,-1) "NONE" 