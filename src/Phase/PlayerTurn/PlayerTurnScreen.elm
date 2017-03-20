module Phase.PlayerTurn.PlayerTurnScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Html.Events exposing (..)
import Matrix exposing (..)
import CommonValues exposing (..)
import Common.Common exposing (..)
import GameValues exposing (..)
import Component.Board exposing (..)
import Component.ValueTable exposing (..)
import Component.ConfirmationDialog exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel as CollectProfitsModel

onStateChange : Model -> PlayerTurnEvent -> (Model, Cmd Msg)
onStateChange model event =
    case event of
        Start playersLeft -> {model|
            playerTurnModel =  startWithPlayers playersLeft
        } ! []
        TileClicked location -> {model|
            playerTurnModel = updateForTileClicked location model.playerTurnModel
        } ! []
        EndTurn -> {model|
            state = CollectProfits
        } ! [
            message (CollectProfitsMsg <| CollectProfitsModel.Start (List.drop 1 model.playerTurnModel.playersLeft) )
        ]

render : Model  -> Html Msg
render model = 
    let
        playersLeft = model.playerTurnModel.playersLeft
        isBuyingLand = model.playerTurnModel.isBuyingLand
        currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list rendering PlayerTurnScreen"
    in
    div [] [
        h1 [] [text <| currentPlayer.name ++ " turn "]
        ,board model.board (\location -> PlayerTurnMsg (TileClicked location))
        ,valueTable model.values
        ,renderBuyConfirmationDialogIfBuying isBuyingLand 0 NoOp NoOp
        ,button [onClick (PlayerTurnMsg EndTurn)] [text "End turn"]
    ]

updateForTileClicked : Location -> PlayerTurnModel -> PlayerTurnModel
updateForTileClicked tileCoordinates oldModel = {oldModel |
    isBuyingLand = True
    ,landBeingBought = tileCoordinates
 }

startWithPlayers : List Player -> PlayerTurnModel
startWithPlayers players = PlayerTurnModel players False (-1, -1)

renderBuyConfirmationDialogIfBuying : Bool -> Int -> Msg -> Msg -> Html Msg
renderBuyConfirmationDialogIfBuying isBuying price yesMsg noMsg = 
    if not isBuying then 
        Html.text ""
    else
        let
          question = "Do you want to buy this land for " ++ toString price
        in
            confirmationFor question NoOp NoOp
        