module Phase.MakingFirstLoans.Components.LoanInputForm exposing (..)

import Html exposing (..)
import Html.Attributes as Attr

loanInput : String -> Int -> Html msg
loanInput playerName minimunValue =
    let
        minimunAsString = toString minimunValue
    in
    div [] [
        Html.text <| "Please " ++ playerName ++ " choose the value of your first loan:",
        Html.input [
            Attr.type_ "number"
            ,Attr.min minimunAsString
            ,Attr.max "15"
            ,Attr.value minimunAsString
        ] []
    ]