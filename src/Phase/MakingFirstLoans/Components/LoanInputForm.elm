module Phase.MakingFirstLoans.Components.LoanInputForm exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import GameValues exposing (..)

loanInput : Player -> Int -> Html msg
loanInput player minimunValue =
    let
        minimunAsString = toString minimunValue
    in
    div [] [
        Html.text <| "Please " ++ player.name ++ " choose the value of your first loan:",
        Html.input [
            Attr.type_ "number"
            ,Attr.min minimunAsString
            ,Attr.max "15"
            ,Attr.value minimunAsString
        ] []
    ]