module Board.Lands exposing (..)

import Css exposing (..)
--import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import Html exposing (..)

type Land = Empty | Crops | GoldMine | Lake | Mountain 

type alias LandTile ={ 
    landType : Land
    , owner : String
}  

type CssClasses =  EmptyTile | CropsTile | GoldMineTile | LakeTile | MountainTile

homepageNamespace : Html.CssHelpers.Namespace String class id msg
homepageNamespace = withNamespace "board"

{ id, class, classList } = homepageNamespace

css : Stylesheet
css =
    (stylesheet << namespace homepageNamespace.name)
    [
        Css.class EmptyTile [ backgroundColor (rgb 200 128 64) ]
        ,Css.class CropsTile [ backgroundColor (rgb 0 255 0) ]
        ,Css.class GoldMineTile [ backgroundColor (rgb 255 255 0) ]
        ,Css.class LakeTile [ backgroundColor (rgb 0 0 255) ]
        ,Css.class MountainTile [ backgroundColor (rgb 255 0 0) ]
    ]

renderLandTilesLine : List LandTile -> Html tr
renderLandTilesLine tileRow = Html.tr [] (List.map (\t -> Html.td [class [EmptyTile]] [Html.text t.owner]) tileRow)

renderLandTiles : List (List LandTile) -> List (Html tr)
renderLandTiles tilesRows = 
    case tilesRows of
        [] -> []
        [x] -> [renderLandTilesLine x]
        x::xs -> renderLandTilesLine x :: renderLandTiles xs

landTiles : List (List LandTile) -> Html b
landTiles tilesRows =
    case tilesRows of
        [] -> Html.text "Empty board"
        [[]] -> Html.text "Empty board"
        all -> Html.div [] (renderLandTiles all)