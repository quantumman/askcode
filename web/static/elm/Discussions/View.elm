module Discussions.View exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Page.Config exposing (..)
import Discussions.Index as Index
import Discussions.Model exposing (Discussion)


view : Route -> List Discussion -> Html Index.Msg
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
