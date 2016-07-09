module Discussions.Model exposing (..)


type alias User =
    { avatar : String
    , name : String
    }


type alias Reply =
    { id : Int
    , description : String
    , code : String
    }


type alias Discussion =
    { subject : String
    , description : String
    , code : String
    , replies : List Reply
    , creator : User
    }


type alias Model =
    List Discussion


init : Model
init =
    []
