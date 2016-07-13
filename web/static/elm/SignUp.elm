module SignUp exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (on, keyCode)
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


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        SignUp ->
            model ! [ signUp model ]

        SignUpSuccess response ->
            model ! []

        SignUpFail error ->
            model ! []


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


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        tagger code =
            if code == 13 then
                msg
            else
                NoOp
    in
        on "keydown" (Decode.map tagger keyCode)
