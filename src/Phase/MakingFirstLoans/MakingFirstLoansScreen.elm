module Phase.MakingFirstLoans.MakingFirstLoansScreen exposing (..)

import CommonValues exposing (..)
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
        } ! []
        OnLoanInput _ -> model ! []

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
            x :: xs -> MakingFirstLoansModel 0 0 x xs