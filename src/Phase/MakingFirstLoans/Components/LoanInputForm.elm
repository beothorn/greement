module Phase.MakingFirstLoans.Components.LoanInputForm exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import GameValues exposing (..)
import Html.Events exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)

import CommonValues exposing (..)
import GameValues exposing (..)


loanInput : Player -> Int -> Html Msg
loanInput player minimunValue =
    let
        minimunAsString = toString minimunValue
    in
    div [] [
        Html.text <| "Please " ++ player.name ++ " choose the value of your first loan: "
        ,Html.input [
            Attr.type_ "number"
            ,Attr.min minimunAsString
            ,Attr.max "15"
            ,Attr.placeholder minimunAsString
            ,onInput (\s -> MakingFirstLoansMsg (OnLoanInput s))
        ] []
        ,button [onClick <| MakingFirstLoansMsg OnAcceptInput] [text "Accept"]
    ]