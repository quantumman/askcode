module SignUp exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http exposing (..)
import Http.Ext as Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Models exposing (..)
import Task exposing (Task)


-- MODEL


type alias Model =
    { email : String
    , password : String
    }


init : Model
init =
    { email = ""
    , password = ""
    }



-- UPDATE


type Msg
    = SignUp
    | SignUpSuccess Credential
    | SignUpFail Http.Error
    | UpdateEmail String
    | UpdatePassword String


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        SignUp ->
            model ! [ signUp model ]

        SignUpSuccess response ->
            model ! []

        SignUpFail error ->
            model ! []

        UpdateEmail email ->
            { model | email = email } ! []

        UpdatePassword password ->
            { model | password = password } ! []


signUp : Model -> Cmd Msg
signUp model =
    let
        task =
            Http.post' decodeCredential
                "/api/registrations"
                (encodeUser model)
    in
        Task.perform SignUpFail SignUpSuccess task



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "card" ]
        [ div [ class "card-block" ]
            [ form
            ]
        ]


form : Html Msg
form =
    Html.form []
        [ fieldset [ class "form-group" ]
            [ label [ for "email" ] [ text "Email" ]
            , input
                [ class "form-control"
                , id "email"
                , placeholder "Email"
                , type' "email"
                , onInput UpdateEmail
                ]
                []
            ]
        , fieldset [ class "form-group" ]
            [ label [ for "password" ] [ text "Password" ]
            , input
                [ class "form-control"
                , id "password"
                , placeholder "Password"
                , type' "password"
                , onInput UpdatePassword
                ]
                []
            ]
        , button [ type' "button", class "btn btn-primary", onClick SignUp ] [ text "JOIN" ]
        ]
