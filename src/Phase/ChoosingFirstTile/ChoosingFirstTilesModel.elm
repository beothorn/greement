module Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

import Matrix exposing (..)

type alias ChoosingFirstTilesModel = {
    lastSelectedTile : (Int,Int)
    ,playerChoosingTile : String
    ,playersLeftChoosingTile : List String
}

type ChoosingFirstTilesEvent = 
    Start
    | OnTileClick Location

initialValue : ChoosingFirstTilesModel
initialValue = ChoosingFirstTilesModel (-1,-1) "NONE" []