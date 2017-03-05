module Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (render, onStateChange)

import Html exposing (..)
import Common.Common exposing (..)
import CommonValues exposing (..)
import GameValues exposing (..)
import Board.Game as Bgame
import Component.Board exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel as LoansModel
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
                playerChoosingTile = choosingFirstTilesModel.playerChoosingTile
                playersLeft = List.filter (\p -> p /= playerChoosingTile) choosingFirstTilesModel.playersLeftChoosingTile
            in
                if isNotValidTile location model.board  then
                    { model | 
                        board = turnTileUp 
                            location 
                            model.board
                        , problems = ["This land can't have an owner, choose again"]
                    } ! []
                else if landAlreadyOwned location model.board  then
                    { model | problems = ["This land is already owned, choose again"]} ! []
                else if landConnectedToLandAlreadyOwned location model.board  then
                { model | 
                    problems = ["You can't choose a land connected to another land already oned, choose again"]
                } ! []
                else if List.isEmpty playersLeft then
                    { model | 
                        board = turnTileUpAnChangeOwner 
                            location 
                            playerChoosingTile 
                            model.board
                        , state = MakingFirstLoans
                        , players = Bgame.updatePlayerLoan playerChoosingTile.name
                            (Bgame.getPriceFor 
                                (Matrix.get location model.board |> unpackOrCry ("Invalid land location "++toString location)).landType 
                                model.values 
                            )
                            model.players
                    } ! [message (MakingFirstLoansMsg LoansModel.Start)]
                else
                    { model | 
                        board = turnTileUpAnChangeOwner 
                            location 
                            playerChoosingTile 
                            model.board 
                        , choosingFirstTilesModel = movePlayerToAlreadyPlayedList 
                            choosingFirstTilesModel 
                            playerChoosingTile
                            playersLeft
                        , players = Bgame.updatePlayerLoan playerChoosingTile.name
                            (Bgame.getPriceFor 
                                (Matrix.get location  model.board |> unpackOrCry ("Invalid land location "++toString location)).landType 
                                model.values
                            )
                            model.players
                    } ! []

render : Model  -> Html Msg
render model = div [] [
    board model.board (\location -> ChoosingFirstTilesMsg (OnTileClick location))
    , Html.text ("Player " ++ model.choosingFirstTilesModel.playerChoosingTile.name ++ " select a tile")
 ]

isNotValidTile : Location -> Matrix LandTile -> Bool
isNotValidTile location board = 
    let
        tileType = (Matrix.get location board |> unpackOrCry ("Invalid land location "++toString location)).landType
    in
        (tileType == Lake) || (tileType == Mountain) 

landAlreadyOwned : Location -> Matrix LandTile -> Bool
landAlreadyOwned location board = 
    let
      maybeLand = Matrix.get location board
    in
        case maybeLand of
            Just land -> land.owner /= GameValues.noPlayer
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
valueFromModel model = 
    let
        players = model.players
    in
        case players of
            [] -> Debug.crash "must have at least two players"
            [x] -> Debug.crash "must have at least two players"
            x :: xs -> ChoosingFirstTilesModel (-1,-1) x xs

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

turnTileUpAnChangeOwner : Location -> Player -> Matrix LandTile -> Matrix LandTile
turnTileUpAnChangeOwner location newOwner board =  
    let
        oldTile = unpackTile ( Matrix.get location board )
        newTile = {oldTile | facingUp = True, owner = newOwner}
    in
        Matrix.set location newTile board

movePlayerToAlreadyPlayedList : ChoosingFirstTilesModel -> Player -> List Player -> ChoosingFirstTilesModel
movePlayerToAlreadyPlayedList model playerChoosingTile playersLeft = 
    { model | 
        playersLeftChoosingTile =  playersLeft
        , playerChoosingTile = List.head playersLeft |> unpackOrCry "No players left, state should have changed"
    }