module Phase.Setup.SetupEvents exposing (
    onPlayerInput
    ,addPlayer
 )

import Msg exposing (..)
import Phase.Setup.SetupModel exposing (..)


onPlayerInput : String -> Msg
onPlayerInput input = SetupMsg <| OnPlayerInput input

addPlayer : Msg
addPlayer = SetupMsg AddPlayer