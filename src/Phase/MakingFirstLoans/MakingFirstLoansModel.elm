module Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)

import GameValues exposing (..)
 
type alias MakingFirstLoansModel = {
    loanValueInput : Int
    ,minimunLoan : Int
    ,playerMakingLoan : Player
    ,playersLeftMakingLoan : List Player
}

type MakingFirstLoansEvent = 
    Start
    | OnLoanInput String
    | OnAcceptInput

initialValue : MakingFirstLoansModel
initialValue = MakingFirstLoansModel 0 0 GameValues.noPlayer []