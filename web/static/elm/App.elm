module App exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Style exposing (..)


app : Program Never
app =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = (always Sub.none)
        }



-- MODEL


type alias User =
    { avatar : String
    }


type alias Model =
    { answerers : List User
    , questioner : User
    }


init : ( Model, Cmd Msg )
init =
    let
        answerers =
            [ { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
            , { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
            , { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
            , { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
            ]

        questioner =
            { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
    in
        ( { answerers = answerers, questioner = questioner }, Cmd.none )



-- UPDATE


type Msg
    = DoSomehting


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoSomehting ->
            ( model, Cmd.none )



-- STYLE


avatarStyle : List Style
avatarStyle =
    [ Style.width (Style.em 2)
    ]



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "container"
        ]
        [ div
            [ class "col-xs-6"
            ]
            [ div
                [ style avatarStyle
                , class "pull-xs-left"
                ]
                [ (avatars [ model.questioner ]) ]
            ]
        , div
            [ class "col-xs-6"
            ]
            [ div
                [ style avatarStyle
                , class "pull-xs-right"
                ]
                [ (avatars model.answerers) ]
            ]
        ]


avatars : List User -> Html Msg
avatars users =
    let
        imageStyle =
            [ Style.width (Style.em 2)
            , Style.height (Style.em 2)
            , Style.marginTop (Style.em 1)
            ]

        avatar x =
            li [ style avatarStyle ]
                [ img
                    [ style imageStyle
                    , class "img-circle"
                    , src x.avatar
                    , alt "avatar"
                    ]
                    []
                ]

        avatars =
            List.map avatar users
    in
        ul
            [ class "list-unstyled"
            ]
            avatars
