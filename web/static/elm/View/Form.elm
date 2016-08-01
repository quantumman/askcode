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


type alias Input error model field =
    { type'' : String
    , getField : String -> Form error model -> Form.FieldState error field
    , inputTag : Form.FieldState error field -> List (Html.Attribute Form.Msg) -> Html Form.Msg
    }
