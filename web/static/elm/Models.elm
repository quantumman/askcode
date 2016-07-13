module Models exposing (..)


type alias User =
    { avatar : String
    , email : String
    }


type alias Credential =
    { jwt : String
    , user : User
    }
