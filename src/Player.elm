module Player exposing (
    Player
    ,noPlayer
 )

type alias Player = {
    name : String,
    money : Int,
    loan : Int
}

noPlayer : Player
noPlayer = Player "" 0 0