module Main exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Board.Game exposing (..)
import CommonValues exposing (..)
import Phase.Setup.SetupScreen exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesScreen exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesModel exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansScreen exposing (..)
import Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)


--main : Program Never Model Msg
--main = beginnerProgram { model = initialState, view = view, update = update }
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
        ("Land",2)
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
    []
    Phase.ChoosingFirstTile.ChoosingFirstTilesModel.initialValue
    Phase.MakingFirstLoans.MakingFirstLoansModel.initialValue
    Phase.Setup.SetupModel.initialValue
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
    Setup ->  renderView model <| Phase.Setup.SetupScreen.render model 
    PlayersChoosingTiles -> renderView model <| Phase.ChoosingFirstTile.ChoosingFirstTilesScreen.render model
    MakingFirstLoans -> renderView model <| Phase.MakingFirstLoans.MakingFirstLoansScreen.render model
    PlayerTurn -> Html.text "NOT IMPLEMENTED"
    PayDebts -> Html.text "NOT IMPLEMENTED"
    CollectProfits -> Html.text "NOT IMPLEMENTED"
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
            SetupMsg event -> Phase.Setup.SetupScreen.onStateChange cleanModel event
            ChoosingFirstTilesMsg event -> Phase.ChoosingFirstTile.ChoosingFirstTilesScreen.onStateChange cleanModel event
            MakingFirstLoansMsg event -> Phase.MakingFirstLoans.MakingFirstLoansScreen.onStateChange cleanModel event