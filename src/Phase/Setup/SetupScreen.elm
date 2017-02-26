module Phase.Setup.SetupScreen exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Json

import CommonValues exposing (..)
import Phase.Setup.SetupModel exposing (..)

onStateChange : Model -> SetupEvent -> Model
onStateChange model event = 
    case event of
        OnPlayerInput input -> {model | 
            setupModel = updateModelForInput model.setupModel input 
        }
        AddPlayer -> {model | 
            players = (model.setupModel.playerInput :: model.players), 
            setupModel = updateModelForInput model.setupModel "" 
        }
        FinishInputting -> {model | state= PlayersChoosingTiles}

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
                    , onInput (\s -> SetupMsg (OnPlayerInput s))
                    , onEnter (SetupMsg AddPlayer) 
                    ]
                    [],
            button [ onClick (SetupMsg AddPlayer)] [ text "Add"],
            button [ onClick (SetupMsg FinishInputting) ] [ text "Start"]
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

updateModelForInput : SetupModel -> String -> SetupModel
updateModelForInput setupModel input = {setupModel | playerInput = input}