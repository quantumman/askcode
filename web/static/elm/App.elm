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


type alias Proposal =
    { description : String
    , votes : Int
    , user : User
    }


type alias Model =
    { answerers : List User
    , question : Proposal
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

        question =
            { description = "I propsed hoge hoge"
            , votes = 1
            , user = { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000" }
            }
    in
        ( { answerers = answerers, question = question }, Cmd.none )



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
            [ div []
                [ (proposalCard model.question) ]
            ]
        , div
            [ class "col-xs-6"
            ]
            [ div
                [ style avatarStyle
                , class "pull-xs-right"
                ]
                [ (avatars 2 model.answerers) ]
            ]
        ]


proposalCard : Proposal -> Html Msg
proposalCard proposal =
    let
        avatarStyle =
            [ Style.marginRight (Style.em 0.5)
            ]
    in
        div [ class "card card-blocks" ]
            [ h4 [ class "card-title" ]
                [ avatar avatarStyle 1.5 proposal.user
                , text "proposed"
                ]
            , p [ class "card-tex" ]
                [text proposal.description]
            ]


avatar : List Style -> Float -> User -> Html Msg
avatar styles size user =
    let
        imageStyle =
            [ Style.width (Style.em size)
            , Style.height (Style.em size)
            ]
    in
        img
            [ style (imageStyle ++ styles)
            , class "img-circle"
            , src user.avatar
            , alt "avatar"
            ]
            []


avatars : Float -> List User -> Html Msg
avatars size users =
    let
        imageStyle =
            [ Style.marginTop (Style.em 1)
            ]

        avatarLi x =
            li [ style avatarStyle ]
                [ avatar imageStyle 2 x ]

        avatars =
            List.map avatarLi users
    in
        ul
            [ class "list-unstyled"
            ]
            avatars
