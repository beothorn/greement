module Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (..)

import Html exposing (..)
import CommonValues exposing (..)
import Component.Board exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

onStateChange : Model -> ChoosingFirstTilesEvent -> Model
onStateChange model event = model

render : Model  -> Html Msg
render model = board model.board (ChoosingFirstTilesMsg OnTileClick)