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
import Http.Extra as Http exposing (..)
import Http.Session as Session exposing (..)
import Models exposing (..)
import Page.UI.Alert as Alert exposing (notify, Model)
import Task exposing (Task)
import View.Form as Form exposing (..)


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
        (get "email" (email `andThen` nonEmpty))
        (get "password" (string `andThen` nonEmpty))



-- UPDATE


type Msg
    = Form Form.Msg
    | SignInSuccess ()
    | SignInFail ErrorMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
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
            model ! []

        SignInFail error ->
            model ! [ Alert.notify <| Alert.Error error ]


-- ACTION

signIn : Account -> Cmd Msg
signIn model =
    let
        request =
            Http.post' decodeCredential
                "/api/sessions"
                (encodeSession model)

        task = request `Task.andThen` Session.store
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
