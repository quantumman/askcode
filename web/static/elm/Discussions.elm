module Discussions exposing (..)

import Discussions.Index as Index exposing (..)
import Discussions.Model as Model exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Page.Config exposing (..)


-- MODEL


type alias Model =
    { index : List Model.Discussion
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { index = []
            }

        command =
            Cmd.batch
                [ Cmd.map IndexMsg Index.fetchCommand
                ]
    in
        ( model, command )



-- UPDATE


type Msg
    = NewMsg
    | EditMsg
    | IndexMsg Index.Msg
    | ShowMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NewMsg ->
            ( model, Cmd.none )

        EditMsg ->
            ( model, Cmd.none )

        IndexMsg subMessage ->
            let
                ( model', command ) =
                    Index.update subMessage model.index
            in
                ( { model | index = model' }, Cmd.map IndexMsg command )

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
            Html.map IndexMsg (Index.view model.index)

        Show id ->
            div [] [ text "show" ]

        NotFound ->
            div [] [ text "NotFound" ]
