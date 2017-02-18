module Main exposing (..)

import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Board.Lands exposing (..)



main : Program Never
main = beginnerProgram { model = "", view = view, update = update }

view: a -> Html b
view model =
  landTiles [
    [ {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Bob"} ]
    , [ {landType = Empty, owner = "Bob"}, {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Bob"} ]
  ]


type Msg = Placeholder

update msg model =
  case msg of
    Placeholder ->
      "nah"