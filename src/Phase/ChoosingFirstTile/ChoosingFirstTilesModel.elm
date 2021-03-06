module Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

import Matrix exposing (..)
import Player exposing (..)

type alias ChoosingFirstTilesModel = {
    lastSelectedTile : (Int,Int)
    ,playersLeft : List Player
}

type ChoosingFirstTilesEvent = 
    Start
    | OnTileClick Location

initialValue : ChoosingFirstTilesModel
initialValue = ChoosingFirstTilesModel (-1,-1) []