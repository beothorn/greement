module Component.Board exposing (
    board
    ,css
 )

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import Html exposing (..)
import Html.Events exposing (..)
import Matrix exposing (..)
import Msg exposing (..)
import LandTile exposing (..)
import Land exposing (..)

board : Matrix LandTile -> (Location -> Msg) -> Html Msg
board tilesRows onclickMsg = Html.table [] (renderLandTiles tilesRows onclickMsg)

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

renderLandTileOnLocation : (Location -> Msg) -> Location -> LandTile -> Html Msg
renderLandTileOnLocation onclickMsg location tile = if tile.facingUp then 
    Html.td [class [tile.landType], onClick (onclickMsg location)] [Html.text tile.owner.name] 
    else Html.td [class [Hidden], onClick (onclickMsg location)] []

renderLandTilesLine : List (Html Msg) -> Html Msg 
renderLandTilesLine tileCellRow = Html.tr [] tileCellRow

renderLandTiles : Matrix LandTile -> (Location -> Msg) -> List (Html Msg)
renderLandTiles tilesRows onclickMsg = 
    List.map renderLandTilesLine (toList (mapWithLocation (renderLandTileOnLocation onclickMsg) tilesRows)) 