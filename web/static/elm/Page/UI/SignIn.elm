module Page.UI.SignIn exposing (..)

import Form exposing (Form)
import Form.Input as Input
import Form.Validate as Validate exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Events.Ext exposing (..)
import Http
import Http.Ext as Http exposing (..)
import Http.Session as Session exposing (..)
import Models exposing (..)
import Page.UI.Alert as Alert exposing (notify, Model)
import View.Form as Form exposing (..)
import Task exposing (Task)


-- MODEL


type alias Account =
    { email : String
    , password : String
    }


type alias Model =
    { form : Form () Account
    }


init : Model
init =
    { form = Form.initial [] validate
    }


validate : Validation () Account
validate =
    form2 Account
        (get "email" string)
        (get "password" string)



-- UPDATE


type Msg
    = NoOp
    | Form Form.Msg
    | SignInSuccess Credential
    | SignInFail ErrorMessage
    | Session Session.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        Form subMessage ->
            let
                form =
                    Form.update subMessage model.form

                commands =
                    if Form.Submit == subMessage then
                        [ Alert.dismiss
                        , Form.getOutput form
                            |> Maybe.map signIn
                            |> Maybe.withDefault Cmd.none
                        ]
                    else
                        [ Cmd.none ]
            in
                ({ model | form = form }) ! commands

        SignInSuccess credential ->
            model ! [ Session.store Session credential ]

        SignInFail error ->
            model ! [ Alert.notify <| Alert.Error error ]

        Session subMessage ->
            model ! []


signIn : Account -> Cmd Msg
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
            [ Html.map Form (form model.form)
            ]
        ]


form : Form () Account -> Html Form.Msg
form form =
    Form.form
        [ Form.input text' form "email" "Email" "Email"
        , Form.input password form "password" "Password" "Password"
        , button [ type' "button", class "btn btn-primary", onClick Form.Submit ] [ text "LOGIN" ]
        ]
