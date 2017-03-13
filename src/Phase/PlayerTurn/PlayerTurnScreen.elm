module Phase.PlayerTurn.PlayerTurnScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import CommonValues exposing (..)
import Phase.PlayerTurn.PlayerTurnModel exposing (..)

onStateChange : Model -> PlayerTurnEvent -> (Model, Cmd Msg)
onStateChange model event = model ! []

render : Model  -> Html Msg
render model = div [] [
    Html.text "NOT IMPLAMENTED"
 ]