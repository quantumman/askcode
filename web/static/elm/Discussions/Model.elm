module Discussions.Model exposing (..)


type alias User =
    { avatar : String
    , name : String
    }


type alias Proposal =
    { id : Int
    , description : String
    , code : String
    , user : User
    , created_at : String
    , updated_at : String
    }


type alias Discussion =
    { proposal : Proposal
    , replies : List Proposal
    }


type alias Model =
    List Discussion


init : Model
init =
    []
