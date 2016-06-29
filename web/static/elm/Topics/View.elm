module Topics.View exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Page.Config exposing (..)
import Topics.Index as Index
import Topics.Model as Topics


view : Route -> Topics.Model -> Html msg
view route model =
    case route of
        New ->
            div [] [ text "new" ]

        Edit id ->
            div [] [ text "edit" ]

        Index ->
            Index.view model

        Show id ->
            div [] [ text "show" ]

        NotFound ->
            div [] [ text "NotFound" ]
