module Component.ValueTable exposing (valueTable)

import Html exposing (..)
import Dict exposing (..)

valueTable : Dict String Int -> Html table
valueTable values = 
    Html.table [] [
        Html.tr [] <| List.map (\v -> Html.th [] [Html.text v]) (Dict.keys values)
        ,Html.tr [] <| List.map (\v -> Html.td [] [Html.text <| toString v]) (Dict.values values)
    ]