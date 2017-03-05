module Phase.MakingFirstLoans.MakingFirstLoansScreen exposing (..)

import Common.Common exposing (..)
import Board.Game exposing (..)
import CommonValues exposing (..)
import GameValues exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)
import Phase.MakingFirstLoans.Components.LoanInputForm exposing (..)
import Html exposing (..)
import Component.Board exposing (..)
import Component.ValueTable exposing (..)
import Matrix exposing (..)

onStateChange : Model -> MakingFirstLoansEvent -> (Model, Cmd Msg)
onStateChange model event = 
    case event of
        Start -> { model | 
            board = turnAllTilesUp model.board
            ,makingFirstLoansModel = valueFromModel model
        } ! []
        OnLoanInput value -> {model | makingFirstLoansModel = updateInput model.makingFirstLoansModel value } ! []
        OnAcceptInput -> 
            let
                makingFirstLoansModel = model.makingFirstLoansModel
                playerMakingLoan = makingFirstLoansModel.playerMakingLoan
                playersLeft = List.filter (\p -> p /= playerMakingLoan) makingFirstLoansModel.playersLeftMakingLoan
            in
                { model | 
                    players = updatePlayerLoan playerMakingLoan.name makingFirstLoansModel.loanValueInput model.players
                    ,makingFirstLoansModel = movePlayerToAlreadyPlayedList makingFirstLoansModel playerMakingLoan playersLeft
                } ! []

render : Model  -> Html Msg
render model = 
    let
        makingLoanModel = model.makingFirstLoansModel
    in
    div [] [
        board model.board (\location -> NoOp)
        , valueTable model.values
        , loanInput makingLoanModel.playerMakingLoan makingLoanModel.minimunLoan
    ] 

turnAllTilesUp : Matrix LandTile -> Matrix LandTile
turnAllTilesUp board = Matrix.map (\ a -> {a| facingUp = True}) board

valueFromModel : Model -> MakingFirstLoansModel
valueFromModel model = 
    let
        players = model.players
    in
        case players of
            [] -> Debug.crash "must have at least two players"
            [x] -> Debug.crash "must have at least two players"
            x :: xs -> MakingFirstLoansModel x.loan x.loan x xs

updateInput : MakingFirstLoansModel -> String -> MakingFirstLoansModel
updateInput oldModel value =  {oldModel | loanValueInput = toIntWithDefault value 0}

movePlayerToAlreadyPlayedList : MakingFirstLoansModel -> Player -> List Player -> MakingFirstLoansModel
movePlayerToAlreadyPlayedList model playerMakingLoan playersLeft = 
    { model | 
        playersLeftMakingLoan =  playersLeft
        , playerMakingLoan = List.head playersLeft |> unpackOrCry "No players left, state should have changed"
    }