module App exposing (..)

import Ace
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
        , subscriptions = subscriptions
        }



-- MODEL


type alias User =
    { avatar : String
    , name : String
    }


type alias Proposal =
    { description : String
    , votes : Int
    , user : User
    , isReply : Bool
    }


type alias Model =
    { answerers : List User
    , reply : Proposal
    , question : Proposal
    , questionCode : Ace.Model
    , replyCode : Ace.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        sampleUser =
            { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
            , name = "test"
            }

        answerers =
            [ sampleUser
            , sampleUser
            , sampleUser
            , sampleUser
            ]

        questioner =
            sampleUser

        reply =
            { description = "I have an opposite opinion..."
            , votes = 20
            , user = sampleUser
            , isReply = True
            }

        question =
            { description = "I propsed hoge hoge"
            , votes = 1
            , user = sampleUser
            , isReply = False
            }
    in
        ( { answerers = answerers
          , reply = reply
          , question = question
          , questionCode = Ace.init "question"
          , replyCode = Ace.init "reply"
          }
        , Cmd.none
        )



-- UPDATE


type Msg
    = DoSomehting
    | AceMsg Ace.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoSomehting ->
            ( model, Cmd.none )

        AceMsg subMsg ->
            let
                question =
                    ( .questionCode, \x -> { model | questionCode = x } )

                reply =
                    ( .replyCode, \x -> { model | replyCode = x } )

                update' ( getter, setter ) ( model', cmds ) =
                    let
                        ( model'', cmd ) =
                            Ace.update subMsg (getter model')
                    in
                        ( setter model'', (Cmd.map AceMsg cmd) :: cmds )

                ( model', cmds ) =
                    (model, [])
                        |> update' question
                        |> update' reply
            in
                ( model', Cmd.batch cmds )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    [ model.questionCode, model.replyCode ]
        |> List.map Ace.subscriptions
        |> List.map (Sub.map AceMsg)
        |> Sub.batch



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
        , id "elm-main-app"
        ]
        [ div
            [ class "col-xs-6"
            ]
            [ div []
                [ (proposalCard model.question)
                , Html.map AceMsg (Ace.view model.questionCode)
                ]
            ]
        , div
            [ class "col-xs-6"
            ]
            [ div []
                [ proposalCard model.reply
                , Html.map AceMsg (Ace.view model.replyCode)
                ]
            , div
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

        header =
            if proposal.isReply then
                [ span []
                    [ text proposal.user.name ]
                , text " repiled"
                , div [ class "pull-xs-right" ]
                    [ avatar avatarStyle 1.5 proposal.user ]
                ]
            else
                [ avatar avatarStyle 1.5 proposal.user
                , text "proposed"
                ]
    in
        div [ class "card card-block" ]
            [ h4 [ class "card-title" ]
                header
            , p [ class "card-text" ]
                [ text proposal.description ]
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

        floatMenuStyle =
            [ position relative
            , top (Style.em -9)
            , right (Style.em -5)
            ]

        avatarLi x =
            li [ style (avatarStyle ++ floatMenuStyle) ]
                [ avatar imageStyle 2 x ]

        avatars =
            List.map avatarLi users
    in
        ul
            [ class "list-unstyled"
            ]
            avatars
