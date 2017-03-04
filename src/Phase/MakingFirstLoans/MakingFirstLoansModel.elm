module Phase.MakingFirstLoans.MakingFirstLoansModel exposing (..)
 
type alias MakingFirstLoansModel = {
    loanValueInput : Int
    ,minimunLoan : Int
    ,playerMakingLoan : String
    ,playersLeftChoosingTile : List String
}

type MakingFirstLoansEvent = 
    Start
    | OnLoanInput String

initialValue : MakingFirstLoansModel
initialValue = MakingFirstLoansModel 0 0 "" []