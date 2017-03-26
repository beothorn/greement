module LandTile exposing(
    LandTile
 )

import Land exposing (Land)
import Player exposing (Player)

type alias LandTile ={ 
    landType : Land
    , owner : Player
    , facingUp : Bool
}  