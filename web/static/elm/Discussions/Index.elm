module Discussions.Index exposing (..)

import Discussions.Model exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Http
import Style exposing (..)
import Styles exposing (..)


-- UPDATE


type Msg
    = Fetch
    | FetchSuccess (List Discussion)
    | FetchError Http.Error



-- VIEW


view : List Discussion -> Html Msg
view model =
    div []
        [ div [ class "row" ]
            (discussions model)
        ]


discussions : List Discussion -> List (Html msg)
discussions discussions =
    let
        item discussion =
            let
                length =
                    List.length discussion.replies
            in
                div [ class "media" ]
                    [ a [ class "media-left", href "#" ]
                        [ img
                            [ class "media-object img-circle"
                            , src discussion.creator.avatar
                            , alt "(^x^)"
                            ]
                            []
                        ]
                    , div [ class "media-body" ]
                        [ h4 [ class "media-heading" ]
                            [ text discussion.subject ]
                        , text discussion.description
                        ]
                    ]
    in
        List.map item discussions