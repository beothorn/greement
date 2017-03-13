module Phase.PlayerTurn.PlayerTurnScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Html.Events exposing (..)
import CommonValues exposing (..)
import Common.Common exposing (..)
import GameValues exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)
import Phase.CollectProfits.CollectProfitsModel as CollectProfitsModel

onStateChange : Model -> PlayerTurnEvent -> (Model, Cmd Msg)
onStateChange model event =
    case event of
        Start playersLeft -> {model|
            playerTurnModel = PlayerTurnModel playersLeft
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
        currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list rendering PlayerTurnScreen"
    in
    div [] [
        h1 [] [text <| currentPlayer.name ++ " turn "]
        ,button [onClick (PlayerTurnMsg EndTurn)] [text "End turn"]
        ,text "NOT IMPLEMENTED"
    ]