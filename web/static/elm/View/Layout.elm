module View.Layout exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


row : List (Html msg) -> Html msg
row content =
    div [ class "row" ] content


column : Int -> List (Html msg) -> Html msg
column n content =
    div [ class ("col-sm-" ++ (toString n)) ] content
