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


encodeUser : { a | email : String, password : String } -> Encode.Value
encodeUser model =
    Encode.object
        [ ( "user"
          , Encode.object
                [ ( "email", Encode.string model.email )
                , ( "password", Encode.string model.password )
                ]
          )
        ]


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
