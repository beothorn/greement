module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Lands exposing (..)
import Board.Game exposing (..)
import CommonValues exposing (..)
import Phase.Setup exposing (..)

main : Program Never Model Msg
main = beginnerProgram { model = initialState, view = view, update = update }

gameConfig : GameConfig
gameConfig = {
    size = 10,
    goldMineCount = 30,
    lakeCount = 5,
    mountainCount =5
 }

initialState : Model
initialState = Model Setup "" []

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

view: Model -> Html Msg
view model =
  case model.state of
  Setup -> div [] [ stylesheet, 
    setupGame model.playerInput model.players
  ]
  PlayesChoosingTiles -> div [] [ stylesheet,
    landTiles (makeBoard gameConfig) model.players 
  ]
  MakingLoans -> Html.text "NOT IMPLEMENTED"
  PlayerTurn -> Html.text "NOT IMPLEMENTED"
  PayDebts -> Html.text "NOT IMPLEMENTED"
  CollectProfits -> Html.text "NOT IMPLEMENTED"
  EventsDraw -> Html.text "NOT IMPLEMENTED"


update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdatePlayerName playerName -> {model | playerInput = playerName}
    AddPlayer -> {model | players = (model.playerInput :: model.players), playerInput = "" }
    FinishAddingPlayers -> {model | state= PlayesChoosingTiles}
