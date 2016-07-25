module Page.UI.Alert exposing (..)

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
