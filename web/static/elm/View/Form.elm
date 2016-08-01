module View.Form exposing (..)

import Form exposing (Form)
import Form.Input as Input
import Form.Validate as Validate exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Events.Ext exposing (..)


form : List (Html Form.Msg) -> Html Form.Msg
form =
    Html.form [ onEnter Form.NoOp Form.Submit ]
