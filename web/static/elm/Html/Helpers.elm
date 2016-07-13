module Html.Helpers exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


row : List (Html msg) -> Html msg
row content =
    div [ class "row" ] content
