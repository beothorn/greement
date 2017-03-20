module Component.ConfirmationDialog exposing (
    confirmationFor
 )

import Html exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import CommonValues exposing (..)

confirmationFor : String -> Msg -> Msg -> Html Msg
confirmationFor question yesResponse noResponse = 
    div [] [
        text question
        ,button [Html.Events.onClick yesResponse] [text "Yes"]
        ,button [Html.Events.onClick noResponse] [text "No"]
    ]