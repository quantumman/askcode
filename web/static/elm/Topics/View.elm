module Topics.View exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routes.Page.Config exposing (..)


view : Route -> Html msg
view route =
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
