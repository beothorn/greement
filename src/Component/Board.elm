module Component.Board exposing (board)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import Html exposing (..)
import Html.Events exposing (..)
import Matrix exposing (..)
import CommonValues exposing (..)

board : Matrix LandTile -> Msg -> Html Msg
board tilesRows onclickMsg =
    let
      tileList = toList tilesRows
    in
        case tileList of
            [] -> Html.text "Empty board"
            [[]] -> Html.text "Empty board"
            all -> Html.table [] (renderLandTiles all onclickMsg)

homepageNamespace : Html.CssHelpers.Namespace String class id msg
homepageNamespace = withNamespace "board"

{ id, class, classList } = homepageNamespace

css : Stylesheet
css =
    (stylesheet << namespace homepageNamespace.name)
    [
        Css.class Empty [ backgroundColor (rgb 200 128 64) ]
        ,Css.class Crops [ backgroundColor (rgb 0 255 0) ]
        ,Css.class GoldMine [ backgroundColor (rgb 255 255 0) ]
        ,Css.class Lake [ backgroundColor (rgb 0 0 255) ]
        ,Css.class Mountain [ backgroundColor (rgb 255 0 0) ]
        ,Css.class Hidden [ backgroundColor (rgb 122 122 122) ]
        ,Css.Elements.table [
            border3 (px 1) solid (rgb 0 0 0)
            , width (pct 100)
        ]
        ,Css.Elements.tr [height (px 30)]
    ]

renderLandTile : Msg -> LandTile -> Html Msg
renderLandTile onclickMsg tile = if tile.facingUp then 
    Html.td [class [tile.landType]] [] 
    else Html.td [class [Hidden], onClick onclickMsg] []

renderLandTilesLine : List LandTile -> Msg -> Html Msg
renderLandTilesLine tileRow onclickMsg = Html.tr [] (List.map (renderLandTile onclickMsg) tileRow)

renderLandTiles : List (List LandTile) -> Msg -> List (Html Msg)
renderLandTiles tilesRows onclickMsg = 
    case tilesRows of
        [] -> []
        [x] -> [renderLandTilesLine x onclickMsg]
        x::xs -> renderLandTilesLine x onclickMsg :: renderLandTiles xs onclickMsg