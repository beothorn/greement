module Phase.Setup.SetupModel exposing (..)

type alias SetupModel = {
    playerInput : String
}

type SetupEvent = 
    OnPlayerInput String
    | AddPlayer

initialValue : SetupModel
initialValue = SetupModel "" 