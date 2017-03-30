module Phase.ChoosingFirstTile.ChoosingFirstTilesEvents exposing (..)

import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Msg exposing (..)
import Matrix exposing (..)

startChoosingFirstTiles : Msg
startChoosingFirstTiles = ChoosingFirstTilesMsg Start

onTileClick : Location -> Msg
onTileClick tileLocation = ChoosingFirstTilesMsg <| OnTileClick tileLocation