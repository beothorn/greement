module Phase.CollectProfits.CollectProfitsScreen exposing (
    render
    ,onStateChange
 )

import Html exposing (..)
import CommonValues exposing (..)
import Phase.CollectProfits.CollectProfitsModel exposing (..)

onStateChange : Model -> CollectProfitsEvent -> (Model, Cmd Msg)
onStateChange model event = model ! []

render : Model  -> Html Msg
render model = div [] [
    Html.text "NOT IMPLAMENTED"
 ]