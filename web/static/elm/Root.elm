module Root exposing (..)

import App
import Discussions
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Helpers as Html exposing (..)
import Page.Login as Login
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
    in
        ( Model routing appModel discussionsModel signUpModel login
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo subMessage ->
            let
                ( routes, command ) =
                    Routing.update subMessage model.routes
            in
                ( { model | routes = routes }, Cmd.map NavigateTo command )

        App subMessage ->
            let
                ( app, command ) =
                    App.update subMessage model.app
            in
                ( { model | app = app }, Cmd.map App command )

        Discussion subMessage ->
            let
                ( model', command ) =
                    Discussions.update subMessage model.discussions
            in
                ( { model | discussions = model' }, Cmd.map Discussion command )

        SignUp subMessage ->
            let
                ( model', command ) =
                    SignUp.update subMessage model.signUp
            in
                { model | signUp = model' } ! [ Cmd.map SignUp command ]

        Login subMessage ->
            Login.update' subMessage model Login



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App (App.subscriptions model.app)



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ navBar model
        , div [ style [ vspace 5 Style.em ] ] []
        , div [ class "container" ] [ (content model) ]
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
