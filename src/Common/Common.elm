module Common.Common exposing (
    unpackOrCry
    ,message
    ,toIntWithDefault
    ,getFromDictOrCry
 )

import Task
import Dict exposing (..)

getFromDictOrCry : comparable -> Dict comparable a -> a 
getFromDictOrCry key dict = 
    let
      value = Dict.get key dict
    in
      unpackOrCry ("Dict does not contain value for " ++ (toString key)) value

unpackOrCry :  String -> Maybe a -> a
unpackOrCry errorMessage maybeValue =
    case maybeValue of
        Just value -> value
        Nothing -> Debug.crash ("Ops, this should not happen: " ++ errorMessage)

message : msg -> Cmd msg
message x = Task.perform identity (Task.succeed x)

toIntWithDefault : String -> Int -> Int
toIntWithDefault value default = String.toInt value |> Result.toMaybe |> Maybe.withDefault default