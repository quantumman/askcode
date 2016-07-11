module Discussions.Model exposing (..)


type alias User =
    { avatar : String
    , name : String
    }


type alias Reply =
    { id : Int
    , description : String
    , code : String
    , creator : User
    }


type alias Discussion =
    { subject : String
    , description : String
    , code : String
    , replies : List Reply
    , creator : User
    }
