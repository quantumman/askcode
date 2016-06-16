port module Ace exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Style


-- MODEL


type alias Model =
    { code : String
    , id : String
    }


init : Model
init =
    { code = "", id = "test" }



-- UPDATE


port initialize : ( Id, String ) -> Cmd msg


type Msg
    = Change String
    | Ready String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change code ->
            ( { model | code = code }, Cmd.none )

        Ready _ ->
            ( model, initialize ( model.id, model.code ) )



-- SUBSCRIPTION


port change : (String -> msg) -> Sub msg


port ready : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ change Change
        , ready Ready
        ]



-- VIEW


type alias Id =
    String


view : Model -> Html Msg
view model =
    div
        [ id model.id
        , style [ Style.height (Style.em 20) ]
        ]
        []
