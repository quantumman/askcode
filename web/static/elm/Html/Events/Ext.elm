module Html.Events.Ext exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (..)


onEnter : msg -> msg -> Attribute msg
onEnter noop msg =
    let
        tagger code =
            if code == 13 then
                msg
            else
                noop
    in
        on "keydown" (Decode.map tagger keyCode)
