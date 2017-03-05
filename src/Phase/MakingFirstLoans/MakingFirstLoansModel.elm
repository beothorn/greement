module Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)

import GameValues exposing (..)
 
type alias MakingFirstLoansModel = {
    loanValueInput : Int
    ,minimunLoan : Int
    ,playerMakingLoan : Player
    ,playersLeftChoosingTile : List Player
}

type MakingFirstLoansEvent = 
    Start
    | OnLoanInput String

initialValue : MakingFirstLoansModel
initialValue = MakingFirstLoansModel 0 0 GameValues.noPlayer []