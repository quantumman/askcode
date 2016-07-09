module Discussions.Model exposing (..)


type alias User =
    { avatar : String
    , name : String
    }

type alias Discussion =
    { subject : String
    }


type alias Model =
    List Discussion


init : Model
init =
    []
