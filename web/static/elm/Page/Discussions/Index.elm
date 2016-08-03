module Page.Discussions.Index exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (..)
import Page.Discussions.Model exposing (..)
import Style exposing (..)
import Styles exposing (..)
import Task exposing (Task)


-- UPDATE


type Msg
    = Fetch
    | FetchSuccess (List Discussion)
    | FetchError Http.Error


update : Msg -> List Discussion -> ( List Discussion, Cmd Msg )
update message model =
    case message of
        Fetch ->
            ( model, fetchCommand )

        FetchSuccess model' ->
            ( model', Cmd.none )

        FetchError _ ->
            ( model, Cmd.none )


fetchCommand : Cmd Msg
fetchCommand =
    let
        decode =
            Decode.list
                (Decode.object5 (\a b c d e -> Discussion a b c [] (User d e))
                    ("subject" := Decode.string)
                    ("description" := Decode.string)
                    ("code" := Decode.string)
                    (Decode.at ["creator", "avatar"] Decode.string)
                    (Decode.at ["creator", "name"] Decode.string)
                )

        task =
            Http.get decode "/api/discussions"
    in
        Task.perform FetchError FetchSuccess task



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
