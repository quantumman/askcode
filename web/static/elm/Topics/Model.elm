module Topics.Model exposing (..)


type alias User =
    { avatar : String
    , name : String
    }


type alias Proposal =
    { id : Int
    , description : String
    , code : String
    , votes : Int
    , user : User
    , created_at : String
    , updated_at : String
    }
