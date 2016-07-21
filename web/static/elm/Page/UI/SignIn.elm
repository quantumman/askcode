module Page.UI.SignIn exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http
import Http.Ext as Http exposing (..)
import Http.Session as Session exposing (..)
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
    = SignIn
    | SignInSuccess Credential
    | SignInFail Http.Error
    | EmailOrUserName String
    | Password String
    | Session Session.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        SignIn ->
            model ! [ signIn model ]

        SignInSuccess credential ->
            model ! [ Session.store Session credential ]

        SignInFail error ->
            model ! []

        EmailOrUserName email ->
            { model | email = email } ! []

        Password password ->
            { model | password = password } ! []

        Session subMessage ->
            model ! []


signIn : Model -> Cmd Msg
signIn model =
    let
        task =
            Http.post' decodeCredential
                "/api/sessions"
                (encodeSession model)
    in
        Task.perform SignInFail SignInSuccess task



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
                , type' "text"
                , onInput EmailOrUserName
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
                , onInput Password
                ]
                []
            ]
        , button [ type' "button", class "btn btn-primary", onClick SignIn ] [ text "LOGIN" ]
        ]
