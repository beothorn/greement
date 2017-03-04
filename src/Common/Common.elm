module Common.Common exposing (..)

import Task

unpackOrCry : Maybe a -> a
unpackOrCry maybeTile =
    case maybeTile of
        Just tile -> tile
        Nothing -> Debug.crash "Ops, this should not happen"

message : msg -> Cmd msg
message x = Task.perform identity (Task.succeed x)