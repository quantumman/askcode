module SignIn exposing (..)

import Http
import Models exposing (..)


-- MODEL


type alias Model =
    { email : String
    , password : String
    }



-- UPDATE


type Msg
    = SignIn
    | SignInSuccess Credential
    | SignInFail Http.Error
    | EmailOrUserName String
    | Password String
