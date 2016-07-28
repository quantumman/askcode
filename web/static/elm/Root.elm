module Root exposing (..)

import App
import Component exposing (..)
import Discussions
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Helpers as Html exposing (..)
import Page.Login as Login
import Page.UI.Alert as Alert
import Page.UI.SignUp as SignUp
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)
import Style exposing (..)
import Styles exposing (..)


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : App.Model
    , discussions : Discussions.Model
    , signUp : SignUp.Model
    , login : Login.Model
    , alert : Alert.Model
    }


init : Routing.Model -> ( Model, Cmd Msg )
init routing =
    let
        ( appModel, appCommand ) =
            App.init

        ( discussionsModel, discussionsCommand ) =
            Discussions.init

        signUpModel =
            SignUp.init

        login =
            Login.init

        alert =
            Alert.init
    in
        ( Model routing appModel discussionsModel signUpModel login alert
        , Cmd.batch
            [ Cmd.map App appCommand
            , Cmd.map Discussion discussionsCommand
            ]
        )



-- UPDATE


type Msg
    = NavigateTo Routing.Msg
    | App App.Msg
    | Discussion Discussions.Msg
    | SignUp SignUp.Msg
    | Login Login.Msg
    | Alert Alert.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo subMessage ->
            Routing.update subMessage model.routes
                |> (\m -> { model | routes = m })
                *> NavigateTo

        App subMessage ->
            App.update subMessage model.app
                |> (\m -> { model | app = m })
                *> App

        Discussion subMessage ->
            Discussions.update subMessage model.discussions
                |> (\m -> { model | discussions = m })
                *> Discussion

        SignUp subMessage ->
            SignUp.update subMessage model.signUp
                |> (\m -> { model | signUp = m })
                *> SignUp

        Login subMessage ->
            Login.update subMessage model.login
                |> (\m -> { model | login = m })
                *> Login

        Alert subMessage ->
            Alert.update subMessage model.alert
                |> (\m -> { model | alert = m })
                *> Alert



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map App (App.subscriptions model.app)
        , Sub.map Alert Alert.subscriptions
        ]



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ navBar model
        , div [ style [ vspace 5 Style.em ] ] []
        , div [ class "container" ]
            [ Html.map Alert (Alert.view model.alert)
            , (content model)
            ]
        ]


content : Model -> Html Msg
content model =
    case model.routes.route of
        Root ->
            topPage model

        Discussions subRoute ->
            Html.map Discussion
                (Discussions.view subRoute model.discussions)

        Routing.SignIn ->
            Html.map Login
                (Login.view model.login)

        NotFound ->
            div [] [ h2 [] [ text "Not Found!" ] ]


navBar : Model -> Html Msg
navBar model =
    nav [ class "navbar navbar-full navbar-fixed-top navbar-light bg-faded" ]
        [ a [ class "navbar-brand", href "#/" ]
            [ text "Ask Code" ]
        , ul [ class "nav navbar-nav" ]
            [ item "Home" (Routing.Discussions Page.Index) model.routes.route
            ]
        , Html.form [ class "form-inline pull-xs-right" ]
            [ button
                [ class "btn btn-outline-primary"
                , type' "button"
                , onClick (NavigateTo Routing.SignIn)
                ]
                [ text "Login" ]
            ]
        ]


item : String -> Routing.Route -> Routing.Route -> Html Msg
item text ref current =
    let
        ref' =
            Routing.reverse ref

        current' =
            Routing.reverse current

        active =
            if ref' == current' then
                "active"
            else
                ""
    in
        li [ class ("nav-item " ++ active) ]
            [ a [ class "nav-link", href ("/#" ++ ref') ]
                [ Html.text text ]
            ]


topPage : Model -> Html Msg
topPage model =
    Html.row
        [ Html.column 12
            [ Html.map SignUp (SignUp.view model.signUp) ]
        , Html.column 12
            [ Html.map Discussion
                (Discussions.view (Page.Index) model.discussions)
            ]
        ]
