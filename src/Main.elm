module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Lands exposing (..)


main = beginnerProgram { model = "", view = view, update = update }

cssFileName = "style.css"

stylesheet =
    let
        tag = "link"
        attrs =
            [ attribute "rel"       "stylesheet"
            , attribute "property"  "stylesheet"
            , attribute "href"      ("./"++cssFileName)
            ]
        children = []
    in 
        node tag attrs children

view: a -> Html b
view model =
  div [] [
    stylesheet, 
    landTiles [
      [ {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Bob"} ]
      ,[ {landType = Empty, owner = "Bob"}, {landType = Empty, owner = "Alice"}, {landType = Empty, owner = "Bob"} ]
    ]
  ]


type Msg = Placeholder

update msg model =
  case msg of
    Placeholder ->
      "nah"