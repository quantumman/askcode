module Discussions.Model exposing (..)


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


type alias Discussion =
    { proposal : Proposal
    , replies : List Proposal
    }


type alias Model =
    List Discussion


init : Model
init =
    let
        sampleUser =
            { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
            , name = "test"
            }

        proposal =
            { id = 100
            , description = "I propsed hoge hoge"
            , code = "int x = 10;"
            , votes = 1
            , user = sampleUser
            , created_at = "December 17, 1995 03:24:00"
            , updated_at = "December 17, 1995 03:24:00"
            }

        replies =
            [ { id = 100
              , description = "I propsed hoge hoge..."
              , code = "var x = 10;"
              , votes = 1
              , user = sampleUser
              , created_at = "December 17, 1995 03:24:00"
              , updated_at = "December 17, 1995 03:24:00"
              }
            , { id = 10
              , description = "I propsed hoge hoge"
              , code = "var x = 10;"
              , votes = 1
              , user = sampleUser
              , created_at = "December 17, 1995 03:24:00"
              , updated_at = "December 17, 1995 03:24:00"
              }
            , { id = 1
              , description = "I propsed hoge hoge"
              , code = "var x = 10;"
              , votes = 1
              , user = sampleUser
              , created_at = "December 17, 1995 03:24:00"
              , updated_at = "December 17, 1995 03:24:00"
              }
            , { id = 9
              , description = "I propsed hoge hoge"
              , code = "var x = 10;"
              , votes = 1
              , user = sampleUser
              , created_at = "December 17, 1995 03:24:00"
              , updated_at = "December 17, 1995 03:24:00"
              }
            ]
    in
        [ Discussion proposal replies ]
