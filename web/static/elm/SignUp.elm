module SignUp exposing (..)

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
