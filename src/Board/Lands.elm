module Board.Lands exposing (..)

import Css exposing (..)
--import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import Html exposing (..)

landTiles : List (List LandTile) -> List String -> Html b
landTiles tilesRows players =
    case tilesRows of
        [] -> Html.text "Empty board"
        [[]] -> Html.text "Empty board"
        all -> Html.div [] ((renderLandTiles all) ++ (List.map Html.text players))

type Land = Empty | Crops | GoldMine | Lake | Mountain 

type alias LandTile ={ 
    landType : Land
    , owner : String
}  

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
    ]

renderLandTilesLine : List LandTile -> Html tr
renderLandTilesLine tileRow = Html.tr [] (List.map (\t -> Html.td [class [t.landType]] [Html.text t.owner]) tileRow)

renderLandTiles : List (List LandTile) -> List (Html tr)
renderLandTiles tilesRows = 
    case tilesRows of
        [] -> []
        [x] -> [renderLandTilesLine x]
        x::xs -> renderLandTilesLine x :: renderLandTiles xs