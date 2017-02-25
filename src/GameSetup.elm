module GameSetup exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import CommonValues exposing (..)

setupGame : String -> List String -> Html Msg
setupGame currentPlayerName players = div [] ([
    input [ placeholder "Player Name"
            , autofocus True
            , value currentPlayerName
            , onInput UpdatePlayerName
            ]
            [],
    button [ onClick AddPlayer] [ text "Add"],
    button [ onClick FinishAddingPlayers ] [ text "Start"]
 ] ++ List.map Html.text players)