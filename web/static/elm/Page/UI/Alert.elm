port module Page.UI.Alert exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Unicode exposing (text')


-- MODEL


type Model
    = Success String
    | Info String
    | Warning String
    | Error String
    | Note String
    | Dismiss


init : Model
init =
    Dismiss


serialize : Model -> ( String, String )
serialize model =
    case model of
        Success m ->
            ( "Success", m )

        Info m ->
            ( "Info", m )

        Warning m ->
            ( "Warning", m )

        Error m ->
            ( "Error", m )

        Note m ->
            ( "Note", m )

        Dismiss ->
            ( "Dismiss", "" )


deserialize : ( String, String ) -> Model
deserialize data =
    case data of
        ( "Success", m ) ->
            Success m

        ( "Info", m ) ->
            Info m

        ( "Warning", m ) ->
            Warning m

        ( "Error", m ) ->
            Error m

        ( "Note", m ) ->
            Note m

        _ ->
            Dismiss



-- UPDATE


port notify' : ( String, String ) -> Cmd msg


notify : Model -> Cmd msg
notify model =
    notify' <| serialize model


type Msg
    = Close
    | Receive ( String, String )


update : Msg -> Model -> ( Model, Cmd msg )
update message model =
    case message of
        Close ->
            ( Dismiss, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        alert message style =
            div [ class ("alert " ++ style) ]
                [ button [ onClick Close, type' "button", class "close" ]
                    [ span [] [ text' "&times;" ]
                    ]
                , text message
                ]
    in
        case model of
            Success text ->
                alert text "alert-success"

            Info text ->
                alert text "alert-info"

            Warning text ->
                alert text "alert-warning"

            Error text ->
                alert text "alert-danger"

            Note text ->
                alert text ""

            Dismiss ->
                div [] []
