module Models exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)


type alias User =
    { avatar : String
    , email : String
    }


type alias Credential =
    { jwt : String
    , user : User
    }



-- JSON


encodeSession : { a | email : String, password : String } -> Encode.Value
encodeSession model =
    Encode.object [ ( "session", encodeSession' model ) ]


encodeRegistration : { a | email : String, password : String } -> Encode.Value
encodeRegistration model =
    Encode.object [ ( "user", encodeSession' model ) ]


encodeSession' : { a | email : String, password : String } -> Encode.Value
encodeSession' model =
    Encode.object
        [ ( "email", Encode.string model.email )
        , ( "password", Encode.string model.password )
        ]


encodeUser : User -> Encode.Value
encodeUser model =
    Encode.object
        [ ( "avatar", Encode.string model.avatar )
        , ( "email", Encode.string model.email )
        ]


decodeUser : Decoder User
decodeUser =
    Decode.object2 User
        ("avatar" := (Decode.null ""))
        ("email" := Decode.string)


encodeCredential : Credential -> Encode.Value
encodeCredential model =
    Encode.object
        [ ( "jwt", Encode.string model.jwt )
        , ( "user", encodeUser model.user )
        ]


decodeCredential : Decoder Credential
decodeCredential =
    Decode.object2 Credential
        ("jwt" := Decode.string)
        ("user" := decodeUser)
