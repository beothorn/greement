module Phase.Setup.SetupScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Json

import Model exposing (..)
import Msg exposing (..)
import Phase.Setup.SetupModel exposing (..)
import Phase.Setup.SetupEvents exposing (..)
import Phase.ChoosingFirstTile.ChoosingFirstTilesEvents exposing (..)

onStateChange : Model -> SetupEvent -> (Model, Cmd Msg)
onStateChange model event = 
    case event of
        OnPlayerInput input -> {model | 
            setupModel = updateModelForInput model.setupModel input 
        } ! []
        AddPlayer -> {model |
            players = ({
                name = model.setupModel.playerInput,
                money  = 0,
                loan = 0
            } :: model.players), 
            setupModel = updateModelForInput model.setupModel "" 
        } ! []

render : Model -> Html Msg
render model = 
    let 
        players = model.players
        currentPlayerName = model.setupModel.playerInput 
    in
        div [] ([
            input [ placeholder "Player Name"
                    , autofocus True
                    , value currentPlayerName
                    , onInput onPlayerInput
                    , onEnter addPlayer
                    ]
                    [],
            button [ onClick addPlayer] [ text "Add"],
            button [ onClick startChoosingFirstTiles ] [ text "Start"]
        ] ++ List.map (\t -> Html.text (t.name ++ " ") ) players)


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

updateModelForInput : SetupModel -> String -> SetupModel
updateModelForInput setupModel input = {setupModel | playerInput = input}