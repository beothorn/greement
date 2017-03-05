module Common.Common exposing (..)

import Task

unpackOrCry :  String -> Maybe a -> a
unpackOrCry errorMessage maybeValue =
    case maybeValue of
        Just value -> value
        Nothing -> Debug.crash ("Ops, this should not happen: " ++ errorMessage)

message : msg -> Cmd msg
message x = Task.perform identity (Task.succeed x)

toIntWithDefault : String -> Int -> Int
toIntWithDefault value default = String.toInt value |> Result.toMaybe |> Maybe.withDefault default