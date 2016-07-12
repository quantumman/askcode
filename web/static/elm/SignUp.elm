module SignUp exposing (..)

import Http exposing (..)
import Models exposing (..)


-- MODEL


type alias Model =
    { email : String
    , password : String
    }


type alias Credential =
    { jwt : String
    , user : User
    }



-- UPDATE


type Msg
    = NoOp
    | SignUp
    | SignUpSuccess Credential
    | SignUpFail Http.Error
