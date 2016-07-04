module Discussions.Index exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Style exposing (..)
import Styles exposing (..)
import Discussions.Model exposing (..)


-- STYLE


center : List Style
center =
    [ margin "0 auto"
    , Style.width (Style.em 30)
    ]


avatar : List Style
avatar =
    [ Style.width (px 64)
    , Style.height (px 64)
    ]



-- VIEW


view : Model -> Html msg
view model =
    div []
        [ div [ style center ]
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
                            [ class "media-object"
                            , style avatar
                            , src discussion.proposal.user.avatar
                            , alt "(^x^)"
                            ]
                            []
                        ]
                    , div [ class "media-body" ]
                        [ h4 [ class "media-heading" ]
                            [ text discussion.subject ]
                        , text discussion.proposal.description
                        ]
                    ]
    in
        List.map item discussions
