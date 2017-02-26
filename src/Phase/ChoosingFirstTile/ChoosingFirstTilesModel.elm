module Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

type alias ChoosingFirstTilesModel = {
    lastSelectedTile : (Int,Int)
    ,playerChoosingTile : String
}

type ChoosingFirstTilesEvent = OnTileClick

initialValue : ChoosingFirstTilesModel
initialValue = ChoosingFirstTilesModel (-1,-1) "NONE" 