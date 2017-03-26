module Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Common.Common exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Player exposing (..)
import LandTile exposing (..)
import Land exposing (..)
import Phase.GamePhases exposing (..)
import Component.Board exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel as CollectProfitsModel
import Matrix exposing (..)

onStateChange : Model -> ChoosingFirstTilesEvent -> (Model, Cmd Msg)
onStateChange model event = 
    case event of
        Start -> {model | 
            state = PlayersChoosingTiles
            ,choosingFirstTilesModel = valueFromModel model
        } ! []
        OnTileClick location -> 
            let
                choosingFirstTilesModel = model.choosingFirstTilesModel
                playerChoosingTile = List.head choosingFirstTilesModel.playersLeft |> unpackOrCry "No Players on list on state change on ChoosingFirstTilesScreen"
                playersLeft = List.drop 1 choosingFirstTilesModel.playersLeft
            in
                if isNotValidTile location model.board  then
                    { model | 
                        board = turnTileUp 
                            location 
                            model.board
                        , problems = ["This land can't be a starting land, choose again"]
                    } ! []
                else if landAlreadyOwned location model.board  then
                    { model | problems = ["This land is already owned, choose again"]} ! []
                else if landConnectedToLandAlreadyOwned location model.board  then
                    { model | 
                        problems = ["You can't choose a land connected to another land already oned, choose again"]
                    } ! []
                else if List.isEmpty playersLeft then
                    { model | 
                        board = assignTileToPlayerAndShowAllTiles 
                            location 
                            playerChoosingTile 
                            model.board
                        , state = CollectProfits
                    } ! [message (CollectProfitsMsg <| CollectProfitsModel.Start model.players )]
                else
                    { model | 
                        board = assignTileToPlayer 
                            location 
                            playerChoosingTile 
                            model.board 
                        , choosingFirstTilesModel = movePlayerToAlreadyPlayedList 
                            choosingFirstTilesModel 
                            playersLeft
                    } ! []

render : Model  -> Html Msg
render model = 
    let
        playerChoosingTile = List.head model.choosingFirstTilesModel.playersLeft |> unpackOrCry "No Players on list on render ChoosingFirstTilesScreen"
    in
    div [] [
        board model.board (\location -> ChoosingFirstTilesMsg (OnTileClick location))
        , Html.text ("Player " ++ playerChoosingTile.name ++ " select a tile")
    ]

isNotValidTile : Location -> Matrix LandTile -> Bool
isNotValidTile location board = 
    let
        tileType = (Matrix.get location board |> unpackOrCry ("Invalid land location "++toString location)).landType
    in
        (tileType == Lake) || (tileType == Mountain) || (tileType == GoldMine) 

landAlreadyOwned : Location -> Matrix LandTile -> Bool
landAlreadyOwned location board = 
    let
      maybeLand = Matrix.get location board
    in
        case maybeLand of
            Just land -> land.owner /= noPlayer
            Nothing ->  False

landConnectedToLandAlreadyOwned : Location -> Matrix LandTile -> Bool
landConnectedToLandAlreadyOwned location board = 
    let
      landRow = Matrix.row location
      landCol = Matrix.col location
    in
        if      landAlreadyOwned (loc  landRow      (landCol - 1)) board then True
        else if landAlreadyOwned (loc  landRow      (landCol + 1)) board then True
        else if landAlreadyOwned (loc (landRow - 1)  landCol     ) board then True 
        else    landAlreadyOwned (loc (landRow + 1)  landCol     ) board

valueFromModel : Model -> ChoosingFirstTilesModel
valueFromModel model = ChoosingFirstTilesModel (-1,-1) model.players

unpackTile : Maybe a -> a
unpackTile maybeTile =
    case maybeTile of
        Just tile -> tile
        Nothing -> Debug.crash "Invalid cell, this should never happen"

turnTileUp : Location -> Matrix LandTile -> Matrix LandTile
turnTileUp location board =  
    let
        oldTile = unpackTile ( Matrix.get location board )
        newTile = {oldTile | facingUp = True}
    in
        Matrix.set location newTile board

assignTileToPlayer : Location -> Player -> Matrix LandTile -> Matrix LandTile
assignTileToPlayer location newOwner board =  
    let
        oldTile = unpackTile ( Matrix.get location board )
        newTile = {oldTile | 
            facingUp = True
            ,owner = newOwner
            ,landType = Crops 
        }
    in
        Matrix.set location newTile board

assignTileToPlayerAndShowAllTiles : Location -> Player -> Matrix LandTile -> Matrix LandTile
assignTileToPlayerAndShowAllTiles location newOwner board =  
    let
        newBoard = assignTileToPlayer location newOwner board
    in
        Matrix.map (\ t -> {t| facingUp = True} )newBoard

movePlayerToAlreadyPlayedList : ChoosingFirstTilesModel -> List Player -> ChoosingFirstTilesModel
movePlayerToAlreadyPlayedList model playersLeft = { model | playersLeft = playersLeft}