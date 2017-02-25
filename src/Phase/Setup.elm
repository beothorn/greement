module Phase.Setup exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Json

import CommonValues exposing (..)

setupGame : String -> List String -> Html Msg
setupGame currentPlayerName players = div [] ([
    input [ placeholder "Player Name"
            , autofocus True
            , value currentPlayerName
            , onInput UpdatePlayerName
            , onEnter AddPlayer 
            ]
            [],
    button [ onClick AddPlayer] [ text "Add"],
    button [ onClick FinishAddingPlayers ] [ text "Start"]
 ] ++ List.map (\t -> Html.text (t ++ " ") ) players)


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)