module Phase.PlayerTurn.PlayerTurnScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Html.Events exposing (..)
import Matrix exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Common.Common exposing (..)
import Player exposing (..)
import LandTile exposing (..)
import Board.ValueTable exposing (..)
import Phase.GamePhases exposing (..)
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
        values = model.values
        playerTurnModel = model.playerTurnModel
        playersLeft = playerTurnModel.playersLeft
        landLocationBeingBought = playerTurnModel.landLocationBeingBought
        landBeingBought = Maybe.withDefault emptyLandTile (Matrix.get landLocationBeingBought model.board)
        isBuyingLand = playerTurnModel.isBuyingLand
        currentTaxPerTile = getFromDictOrCry "Distance tax"  model.values
        currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list rendering PlayerTurnScreen"
    in
    div [] [
        h1 [] [text <| currentPlayer.name ++ " turn "]
        ,board model.board (\location -> PlayerTurnMsg (TileClicked location))
        ,valueTable model.values
        ,renderBuyConfirmationDialogIfBuying 
            isBuyingLand 
            (getPriceFor landBeingBought.landType values)
            (getTaxValueFor currentPlayer model.board landLocationBeingBought currentTaxPerTile ) 
            NoOp 
            NoOp
        ,button [onClick (PlayerTurnMsg EndTurn)] [text "End turn"]
    ]

manhatanDistanceBetween : Location -> Location -> Int
manhatanDistanceBetween loc1 loc2 = (abs ((row loc1) - (row loc2))) + (abs ((Matrix.col loc1) - (Matrix.col loc2)))

type alias LandWitLocation ={ 
    owner : Player
    , location : Location
}  

getTaxValueFor : Player -> Matrix LandTile -> Location -> Int -> Int
getTaxValueFor playerBuying board desiredLand taxPerTile = 
    let
        flattenBoard = flatten <| mapWithLocation (\ location land -> LandWitLocation land.owner location ) board
        onlyTilesOwnedByBuyer = List.filter (\ landWitLocation -> landWitLocation.owner.name == playerBuying.name) flattenBoard
        ownedTileDistance = List.map (\ l -> manhatanDistanceBetween l.location desiredLand) onlyTilesOwnedByBuyer
        smallestDistance = List.minimum ownedTileDistance |> unpackOrCry "Something weird goin on getSellingValueFor, is the list empty?"
    in
        smallestDistance * taxPerTile

updateForTileClicked : Location -> PlayerTurnModel -> PlayerTurnModel
updateForTileClicked tileCoordinates oldModel = {oldModel |
    isBuyingLand = True
    ,landLocationBeingBought = tileCoordinates
 }

startWithPlayers : List Player -> PlayerTurnModel
startWithPlayers players = PlayerTurnModel players False (-1, -1)

renderBuyConfirmationDialogIfBuying : Bool -> Int -> Int -> Msg -> Msg -> Html Msg
renderBuyConfirmationDialogIfBuying isBuying price tax yesMsg noMsg = 
    if not isBuying then 
        Html.text ""
    else
        let
            total = price + tax
            priceStr = toString price
            taxStr = toString tax
            totalStr = toString total
            question = "Do you want to buy this land for " ++ priceStr ++ " plus tax " ++ taxStr ++ " (total " ++ totalStr ++ ") ?"
        in
            confirmationFor question NoOp NoOp
        