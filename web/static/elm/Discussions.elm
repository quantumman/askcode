module Discussions exposing (..)

import Discussions.Model exposing (Model)


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
