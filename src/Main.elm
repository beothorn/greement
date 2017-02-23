module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Lands exposing (..)
import Board.Game exposing (..)

gameConfig : GameConfig
gameConfig = {
    size = 10,
    goldMineCount = 30,
    lakeCount = 5,
    mountainCount =5
 }

players : List String
players = ["Alice", "Bob", "Carol"]

main : Program Never String Msg
main = beginnerProgram { model = "", view = view, update = update }

cssFileName : String
cssFileName = "style.css"

stylesheet : Html msg
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
    makeBoard gameConfig players 
      |> landTiles
  ]


type Msg = Placeholder

update msg model =
  case msg of
    Placeholder ->
      "nah"