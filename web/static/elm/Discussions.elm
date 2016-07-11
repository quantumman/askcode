module Discussions exposing (..)

import Discussions.Model as Model exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Page.Config exposing (..)


-- MODEL


type alias Model =
    { index : List Model.Discussion
    }


init : Model
init =
    { index = []
    }



-- UPDATE


type Msg
    = NewMsg
    | EditMsg
    | IndexMsg
    | ShowMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NewMsg ->
            ( model, Cmd.none )

        EditMsg ->
            ( model, Cmd.none )

        IndexMsg ->
            ( model, Cmd.none )

        ShowMsg ->
            ( model, Cmd.none )



-- VIEW


view : Route -> Model -> Html Msg
view route model =
    case route of
        New ->
            div [] [ text "new" ]

        Edit id ->
            div [] [ text "edit" ]

        Index ->
            div [] [ text "index" ]

        Show id ->
            div [] [ text "show" ]

        NotFound ->
            div [] [ text "NotFound" ]
