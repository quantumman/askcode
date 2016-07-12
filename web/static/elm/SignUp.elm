module SignUp exposing (..)

import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models exposing (..)
import Task exposing (Task)


-- MODEL


type alias Model =
    { email : String
    , password : String
    }


type alias Credential =
    { jwt : String
    , user : User
    }



-- UPDATE


type Msg
    = NoOp
    | SignUp
    | SignUpSuccess Credential
    | SignUpFail Http.Error


signUp : Model -> Cmd Msg
signUp model =
    let
        decode =
            Decode.object2 Credential
                ("jwt" := Decode.string)
                ("user" := decodeUser)

        decodeUser =
            Decode.object2 User
                ("avatar" := Decode.string)
                ("email" := Decode.string)

        user =
            Encode.object
                [ ( "user"
                  , Encode.object
                        [ ( "email", Encode.string model.email )
                        , ( "password", Encode.string model.password )
                        ]
                  )
                ]

        task =
            Http.send Http.defaultSettings
                { verb = "POST"
                , headers = [ ( "Content-Type", "application/json" ) ]
                , url = Http.url "/api/registrations" []
                , body = Http.string (Encode.encode 0 user)
                }
                |> Http.fromJson decode
    in
        Task.perform SignUpFail SignUpSuccess task
