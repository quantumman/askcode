module Root exposing (..)

import App
import Component exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http.Session as Session exposing (..)
import Models exposing (..)
import Page.Discussions as Discussions
import Page.Login as Login
import Page.UI.Alert as Alert
import Page.UI.Navbar as Navbar exposing (..)
import Page.UI.SignUp as SignUp
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)
import Style exposing (..)
import Styles exposing (..)
import Task exposing (Task)
import View.Layout as View exposing (..)


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : App.Model
    , discussions : Discussions.Model
    , signUp : SignUp.Model
    , login : Login.Model
    , alert : Alert.Model
    , navbar : Navbar.Model
    , isLoggedIn : Bool
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

        navbar =
            Navbar.init routing
    in
        ( Model routing appModel discussionsModel signUpModel login alert navbar False
        , Cmd.batch
            [ Cmd.map App appCommand
            , Cmd.map Discussion discussionsCommand
            , Session.load' (LoadSession)
            ]
        )



-- UPDATE


type Msg
    = NavigateTo Routing.Msg
    | LoadSession (Maybe Credential)
    | App App.Msg
    | Discussion Discussions.Msg
    | SignUp SignUp.Msg
    | Login Login.Msg
    | Alert Alert.Msg
    | Navbar Navbar.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo subMessage ->
            Routing.update subMessage model.routes
                |> (\m -> { model | routes = m })
                *> NavigateTo

        LoadSession credential ->
            let
                navbar =
                    model.navbar

                navbar' =
                    case credential of
                        Just x ->
                            { navbar | isLoggedIn = True, user = x.user }

                        Nothing ->
                            { navbar | isLoggedIn = False }
            in
                { model | navbar = navbar' } ! []

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

        Navbar subMessage ->
            Navbar.update subMessage model.navbar
                |> (\m -> { model | navbar = m })
                *> Navbar



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
        [ Navbar.view model.navbar
            [ menuItem "Home" Navbar.Home
            ]
            |> Html.map Navbar
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


topPage : Model -> Html Msg
topPage model =
    View.row
        [ View.column 12
            [ Html.map SignUp (SignUp.view model.signUp) ]
        , View.column 12
            [ Html.map Discussion
                (Discussions.view (Page.Index) model.discussions)
            ]
        ]
