module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Game exposing (..)
import CommonValues exposing (..)
import Phase.Setup.SetupScreen exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)

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
initialState = Model 
    Setup 
    [] 
    (makeBoard gameConfig) 
    Phase.ChoosingFirstTile.ChoosingFirstTilesModel.initialValue
    Phase.Setup.SetupModel.initialValue

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
    Phase.Setup.SetupScreen.render model
  ]
  PlayersChoosingTiles -> div [] [ stylesheet,
    Phase.ChoosingFirstTile.ChoosingFirstTilesScreen.render model
  ]
  MakingLoans -> Html.text "NOT IMPLEMENTED"
  PlayerTurn -> Html.text "NOT IMPLEMENTED"
  PayDebts -> Html.text "NOT IMPLEMENTED"
  CollectProfits -> Html.text "NOT IMPLEMENTED"
  EventsDraw -> Html.text "NOT IMPLEMENTED"
  

update : Msg -> Model -> Model
update msg model =
  case msg of
    SetupMsg event -> Phase.Setup.SetupScreen.onStateChange model event
    ChoosingFirstTilesMsg event -> Phase.ChoosingFirstTile.ChoosingFirstTilesScreen.onStateChange model event
