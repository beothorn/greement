module Phase.ChoosingFirstTile.ChoosingFirstTilesEvents exposing (
    startChoosingFirstTiles
    ,onTileClick
 )

import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Msg exposing (..)
import Matrix exposing (..)

startChoosingFirstTiles : Msg
startChoosingFirstTiles = ChoosingFirstTilesMsg Start

onTileClick : Location -> Msg
onTileClick tileLocation = ChoosingFirstTilesMsg <| OnTileClick tileLocation