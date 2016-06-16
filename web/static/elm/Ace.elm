port module Ace exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    { code : String
    }


init : Model
init =
    { code = "" }



-- UPDATE


port send : String -> Cmd msg


type Msg
    = Change String
    | Ready String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change code ->
            ( { model | code = code }, Cmd.none )

        Ready _ ->
            ( model, send model.code )



-- SUBSCRIPTION


port change : (String -> msg) -> Sub msg


port ready : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ change Change
        , ready Ready
        ]
