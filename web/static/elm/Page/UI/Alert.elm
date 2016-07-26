module Page.UI.Alert exposing (..)

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



-- UPDATE


type Msg
    = Close


update : Msg -> Model -> ( Model, Cmd msg )
update message model =
    case message of
        Close ->
            ( Dismiss, Cmd.none )


update' : Msg -> { model | alert : Model } -> (Msg -> msg) -> ( { model | alert : Model }, Cmd msg )
update' message rootModel fmsg =
    let
        model =
            rootModel.alert

        ( model', command ) =
            update message model
    in
        ( { rootModel | alert = model' }, Cmd.map fmsg command )



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
