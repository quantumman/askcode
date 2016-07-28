port module Page.UI.Alert exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Unicode exposing (text')


-- MODEL


type alias Model =
    List Message


type Message
    = Success String
    | Info String
    | Warning String
    | Error String
    | Note String


init : Model
init =
    []


serialize : Message -> ( String, String )
serialize message =
    case message of
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


deserialize : ( String, String ) -> Message
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
            Debug.crash "Fatal: unexected data received"



-- UPDATE


port notify' : ( String, String ) -> Cmd msg


notify : Message -> Cmd msg
notify model =
    notify' <| serialize model


type Msg
    = Close
    | Receive ( String, String )


update : Msg -> Model -> ( Model, Cmd msg )
update message model =
    case message of
        Close ->
            ( [], Cmd.none )

        Receive m ->
            ( deserialize m :: model, Cmd.none )



-- SUBSCRIPTION


port receive : (( String, String ) -> msg) -> Sub msg


subscriptions : Sub Msg
subscriptions =
    receive Receive



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

        print message =
            case message of
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
    in
        div [] (List.map print model)

