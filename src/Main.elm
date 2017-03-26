module Main exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Game exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Phase.GamePhases exposing (..)
import Phase.Setup.SetupScreen as SetupScreen
import Phase.Setup.SetupModel as SetupModel
import Phase.ChoosingFirstTile.ChoosingFirstTilesScreen as ChoosingFirstTilesScreen
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel as ChoosingFirstTilesModel 
import Phase.PlayerTurn.PlayerTurnScreen as PlayerTurnScreen
import Phase.PlayerTurn.PlayerTurnModel as PlayerTurnModel 
import Phase.CollectProfits.CollectProfitsScreen as CollectProfitsScreen
import Phase.CollectProfits.CollectProfitsModel as CollectProfitsModel 


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


gameConfig : GameConfig
gameConfig = {
    size = 10,
    goldMineCount = 30,
    lakeCount = 5,
    mountainCount =5
 }

init : (Model, Cmd Msg)
init = (Model 
    Setup 
    [] 
    (makeBoard gameConfig) 
    (Dict.fromList [
        (  "Land",2)
        , ("Seed",2)
        , ("Crop profit",3)
        , ("Gold mine",5)
        , ("Gold mine profit",4)
        , ("Lake multiplier",1)
        , ("Mountain multiplier",1)
        , ("Distance tax",4)
        , ("Loan multiplier",2)
        , ("Cattle",5)
        , ("Cattle profit",6)
        , ("Action card", 15)
    ])
    0
    []
    SetupModel.initialValue
    ChoosingFirstTilesModel.initialValue
    CollectProfitsModel.initialValue
    PlayerTurnModel.initialValue
 ) ! []

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
 
renderView : Model -> Html Msg -> Html Msg
renderView model element = div [] <| [stylesheet] ++ (List.map Html.text model.problems) ++ [element]

view: Model -> Html Msg
view model =
  case model.state of
    Setup ->  renderView model <| SetupScreen.render model 
    PlayersChoosingTiles -> renderView model <| ChoosingFirstTilesScreen.render model
    CollectProfits -> renderView model <| CollectProfitsScreen.render model
    PlayerTurn -> renderView model <| PlayerTurnScreen.render model
    PayDebts -> Html.text "NOT IMPLEMENTED"
    EventsDraw -> Html.text "NOT IMPLEMENTED"
  

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
      cleanModel = {model | problems = []}
    in
        case msg of
            NoOp -> (model, Cmd.none)
            SetupMsg event -> SetupScreen.onStateChange cleanModel event
            ChoosingFirstTilesMsg event -> ChoosingFirstTilesScreen.onStateChange cleanModel event
            CollectProfitsMsg event -> CollectProfitsScreen.onStateChange cleanModel event
            PlayerTurnMsg event -> PlayerTurnScreen.onStateChange cleanModel event