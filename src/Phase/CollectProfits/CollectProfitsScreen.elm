module Phase.CollectProfits.CollectProfitsScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Matrix exposing (..)
import Dict exposing (..)
import Model exposing (..)
import Msg exposing (..)
import LandTile exposing (..)
import Common.Common exposing (..)
import Player exposing (..)
import Board.ValueTable exposing (..)
import Phase.GamePhases exposing (..)
import Html.Events exposing (..)
import Common.Common exposing (..)
import Phase.CollectProfits.CollectProfitsModel exposing (..)
import Phase.PlayerTurn.PlayerTurnModel as PlayerTurnModel

onStateChange : Model -> CollectProfitsEvent -> (Model, Cmd Msg)
onStateChange model event = 
    case event of 
        Start playersLeft -> 
            let
                currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list onStateChange CollectProfitsScreen"
                profit = calculateProfitFor currentPlayer model.board model.values
            in
            {model| 
                collectProfitsModel = CollectProfitsModel profit playersLeft 
                ,players = giveProfitToPlayer currentPlayer model.players profit
            } ! []
        StartTurn -> {model|state = PlayerTurn} ! [
            message (PlayerTurnMsg <| PlayerTurnModel.Start model.collectProfitsModel.playersLeft)
        ]

render : Model  -> Html Msg
render model = 
    let
        playersLeft = model.collectProfitsModel.playersLeft
        currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list rendering CollectProfitsScreen"
        currentPlayerProfit = model.collectProfitsModel.currentPlayerProfit
    in
    div [] [
        text <| "Player "++currentPlayer.name++" receives "++(toString currentPlayerProfit)++"c ."
        ,button [onClick (CollectProfitsMsg StartTurn)] [ text "Start turn"]
    ]

calculateProfitFor : Player -> Matrix LandTile -> Dict String Int -> Int
calculateProfitFor player board valueTable= 
    let
        allLands = Matrix.flatten board
        allLandValue = List.map (\l -> if l.owner.name == player.name then (getProfitFor l.landType valueTable) else 0 ) allLands
    in
        List.sum allLandValue

giveProfitToPlayer : Player -> List Player -> Int -> List Player
giveProfitToPlayer player players profit = 
    List.map 
    (\p -> 
        if p == player then { p |
            money = p.money+profit
        } else p
    ) 
    players