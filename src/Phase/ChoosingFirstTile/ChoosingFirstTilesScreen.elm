module Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (..)

import Html exposing (..)
import CommonValues exposing (..)
import Component.Board exposing (..)
import Component.ValueTable exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Matrix exposing (..)
import Common.Common exposing (..)

onStateChange : Model -> ChoosingFirstTilesEvent -> Model
onStateChange model event = 
    case event of
        Start -> {model | 
            state = PlayersChoosingTiles
            ,choosingFirstTilesModel = valueFromModel model
        }
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
                    }
                else if landAlreadyOwned location model.board  then
                    { model | 
                        board = turnTileUp 
                            location 
                            model.board
                        , problems = ["This land is already owned, choose again"]
                    }
                else if List.isEmpty playersLeft then
                    { model | 
                        board = turnTileUpAnChangeOwner 
                            location 
                            playerChoosingTile 
                            model.board |> turnAllTilesUp
                        , state = MakingFirstLoans
                    }
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
                    }

render : Model  -> Html Msg
render model = div [] [
    board model.board (\location -> ChoosingFirstTilesMsg (OnTileClick location))
    , Html.text ("Player " ++ model.choosingFirstTilesModel.playerChoosingTile ++ " select a tile")
    , valueTable model.values
 ]

isNotValidTile : Location -> Matrix LandTile -> Bool
isNotValidTile location board = 
    let
        tileType = (Matrix.get location board |> unpackOrCry).landType
    in
        (tileType == Lake) || (tileType == Mountain) 

landAlreadyOwned : Location -> Matrix LandTile -> Bool
landAlreadyOwned location board = (Matrix.get location board |> unpackOrCry).owner /= noOwner

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

turnTileUpAnChangeOwner : Location -> String -> Matrix LandTile -> Matrix LandTile
turnTileUpAnChangeOwner location newOwner board =  
    let
        oldTile = unpackTile ( Matrix.get location board )
        newTile = {oldTile | facingUp = True, owner = newOwner}
    in
        Matrix.set location newTile board

turnAllTilesUp : Matrix LandTile -> Matrix LandTile
turnAllTilesUp board = Matrix.map (\ a -> {a| facingUp = True}) board

movePlayerToAlreadyPlayedList : ChoosingFirstTilesModel -> String -> List String-> ChoosingFirstTilesModel
movePlayerToAlreadyPlayedList model playerChoosingTile playersLeft = 
    { model | 
        playersLeftChoosingTile =  playersLeft
        , playerChoosingTile = List.head playersLeft |> unpackOrCry
    }