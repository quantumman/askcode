module Models exposing (..)

import Json.Decode as Decode exposing (..)


type alias User =
    { avatar : String
    , email : String
    }


type alias Credential =
    { jwt : String
    , user : User
    }



-- JSON


decodeUser : Decoder User
decodeUser =
    Decode.object2 User
        ("avatar" := Decode.string)
        ("email" := Decode.string)


decodeCredential : Decoder Credential
decodeCredential =
    Decode.object2 Credential
        ("jwt" := Decode.string)
        ("user" := decodeUser)
