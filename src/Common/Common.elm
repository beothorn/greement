module Common.Common exposing (..)

unpackOrCry : Maybe a -> a
unpackOrCry maybeTile =
    case maybeTile of
        Just tile -> tile
        Nothing -> Debug.crash "Ops, this should not happen"