module Html.Extra exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode as Json


role : String -> Attribute msg
role r =
    property "role" <| Json.string r
