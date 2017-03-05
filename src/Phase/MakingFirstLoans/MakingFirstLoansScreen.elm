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
        OnLoanInput value -> {model | 
            makingFirstLoansModel = updateInput model.makingFirstLoansModel value model.makingFirstLoansModel.minimunLoan 
        } ! []
        OnAcceptInput -> 
            let
                makingFirstLoansModel = model.makingFirstLoansModel
                playerMakingLoan = makingFirstLoansModel.playerMakingLoan
                playersLeft = List.filter (\p -> p /= playerMakingLoan) makingFirstLoansModel.playersLeftMakingLoan
            in
                if List.isEmpty playersLeft then 
                    { model | 
                        state = PlayerTurn
                    } ! []
                else 
                    { model | 
                        players = 
                            updatePlayerLoan playerMakingLoan.name makingFirstLoansModel.loanValueInput model.players
                            |> updatePlayerMoney playerMakingLoan.name (makingFirstLoansModel.loanValueInput - playerMakingLoan.loan)
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

updateInput : MakingFirstLoansModel -> String -> Int -> MakingFirstLoansModel
updateInput oldModel value default = 
    let
        newValue = toIntWithDefault value default
    in 
        if newValue <= 15 then {oldModel | loanValueInput = newValue} else {oldModel | loanValueInput = 15}

movePlayerToAlreadyPlayedList : MakingFirstLoansModel -> Player -> List Player -> MakingFirstLoansModel
movePlayerToAlreadyPlayedList model playerMakingLoan playersLeft = 
    let
      nextPlayer = List.head playersLeft |> unpackOrCry "No players left, state should have changed"
    in
        { model | 
            playersLeftMakingLoan =  playersLeft
            ,playerMakingLoan = nextPlayer
            ,minimunLoan = nextPlayer.loan
            ,loanValueInput = nextPlayer.loan
        }