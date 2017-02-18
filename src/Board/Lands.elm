module Board.Lands exposing (..)

import Html exposing (..)

type Land = Empty | Crops | GoldMine | Lake | Mountain 

type alias LandTile ={ 
    landType : Land
    , owner : String
}  

renderLandTilesLine : List LandTile -> Html tr
renderLandTilesLine tileRow = tr [] (List.map (\t -> td [] [text t.owner]) tileRow)

renderLandTiles : List (List LandTile) -> List (Html tr)
renderLandTiles tilesRows = 
    case tilesRows of
        [] -> []
        [x] -> [renderLandTilesLine x]
        x::xs -> renderLandTilesLine x :: renderLandTiles xs

landTiles : List (List LandTile) -> Html b
landTiles tilesRows =
    case tilesRows of
        [] -> text "Empty board"
        [[]] -> text "Empty board"
        all -> div [] (renderLandTiles all)