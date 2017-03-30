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
import Phase.PlayerTurn.PlayerTurnEvents exposing (..)
import Phase.CollectProfits.CollectProfitsEvents exposing (..)

onStateChange : Model -> PlayerTurnEvent -> (Model, Cmd Msg)
onStateChange model event =
    let
      playerTurnModel = model.playerTurnModel
      currentPlayer = List.head playerTurnModel.playersLeft |> unpackOrCry "Impossible! no player playing"
      landLocationBeingBought = playerTurnModel.landLocationBeingBought
      landBeingBought = getlandBeingBought landLocationBeingBought model.board
    in
        case event of
            Start playersLeft -> {model|
                playerTurnModel =  startWithPlayers playersLeft
            } ! []
            TileClicked location -> {model|
                playerTurnModel = updateForTileClicked location playerTurnModel
            } ! []
            BuyClicked -> if hasMoneyToBuy currentPlayer landBeingBought then 
                buyLand currentPlayer landLocationBeingBought model ! []
                else
                showCantBuyMessageForLackOfMoney currentPlayer model ! []
            DontBuyClicked -> {model|
                playerTurnModel = updateDontBuyClicked playerTurnModel
            } ! []
            EndTurn -> {model|
                state = CollectProfits
            } ! [
                message (startCollectProfits (List.drop 1 playerTurnModel.playersLeft) )
            ]

render : Model  -> Html Msg
render model = 
    let
        values = model.values
        playerTurnModel = model.playerTurnModel
        playersLeft = playerTurnModel.playersLeft
        landLocationBeingBought = playerTurnModel.landLocationBeingBought
        landBeingBought = getlandBeingBought landLocationBeingBought model.board
        isBuyingLand = playerTurnModel.isBuyingLand
        currentTaxPerTile = getFromDictOrCry distanceTaxKey model.values
        price = getPriceFor landBeingBought.landType values
        tax = getTaxValueFor currentPlayer model.board landLocationBeingBought currentTaxPerTile 
        currentPlayer = List.head playersLeft |> unpackOrCry "No Players on list rendering PlayerTurnScreen"
    in
    div [] [
        h1 [] [text <| currentPlayer.name ++ " turn "]
        ,board model.board tileClicked
        ,valueTable model.values
        ,renderBuyConfirmationDialogIfBuying isBuyingLand price tax
        ,button [onClick endTurn] [text "End turn"]
    ]

getlandBeingBought : Location -> Matrix LandTile -> LandTile
getlandBeingBought landLocationBeingBought board = Maybe.withDefault emptyLandTile (Matrix.get landLocationBeingBought board)

hasMoneyToBuy : Player -> LandTile -> Bool
hasMoneyToBuy player land = True

buyLand : Player -> Location -> Model -> Model
buyLand buyer landLocation model = model

showCantBuyMessageForLackOfMoney : Player -> Model -> Model
showCantBuyMessageForLackOfMoney buyer model = model

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
        smallestDistance = List.minimum ownedTileDistance |> unpackOrCry "Something weird going on with getSellingValueFor, is the list empty?"
    in
        smallestDistance * taxPerTile

updateForTileClicked : Location -> PlayerTurnModel -> PlayerTurnModel
updateForTileClicked tileCoordinates oldModel = {oldModel |
    isBuyingLand = True
    ,landLocationBeingBought = tileCoordinates
 }

updateDontBuyClicked : PlayerTurnModel -> PlayerTurnModel
updateDontBuyClicked oldModel = {oldModel |
    isBuyingLand = False
 }

startWithPlayers : List Player -> PlayerTurnModel
startWithPlayers players = PlayerTurnModel players False (-1, -1)

renderBuyConfirmationDialogIfBuying : Bool -> Int -> Int -> Html Msg
renderBuyConfirmationDialogIfBuying isBuying price tax = 
    let
        total = price + tax
        priceStr = toString price
        taxStr = toString tax
        totalStr = toString total
        question = "Do you want to buy this land for " ++ priceStr ++ " plus tax " ++ taxStr ++ " (total " ++ totalStr ++ ") ?"
    in
        renderIf isBuying (
            confirmationFor question buyClicked dontBuyClicked
        )
        