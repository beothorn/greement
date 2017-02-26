module Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (..)

import Html exposing (..)
import CommonValues exposing (..)
import Component.Board exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Matrix exposing (..)

onStateChange : Model -> ChoosingFirstTilesEvent -> Model
onStateChange model event = 
    case event of
        OnTileClick location -> {model | board = turnTileUp location model.board }

render : Model  -> Html Msg
render model = board model.board (\location -> ChoosingFirstTilesMsg (OnTileClick location))

unpackTile : Maybe a -> a
unpackTile maybeTile =
    case maybeTile of
        Just tile -> tile
        Nothing -> Debug.crash "Invalid cell, this should never happen"

turnTileUp : Location -> Matrix LandTile -> Matrix LandTile
turnTileUp location board =  
    let
        oldTile = unpackTile ( Matrix.get location board )
    in
        Matrix.set location {oldTile | facingUp = True} board