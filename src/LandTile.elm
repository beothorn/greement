module LandTile exposing(
    LandTile
    ,emptyLandTile
 )

import Land exposing (Land)
import Player exposing (Player)

type alias LandTile ={ 
    landType : Land
    , owner : Player
    , facingUp : Bool
}  

emptyLandTile : LandTile
emptyLandTile = LandTile Land.Empty Player.noPlayer False