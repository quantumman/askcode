module Root exposing (..)

import App
import Discussions
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Helpers as Html exposing (..)
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)
import Page.UI.SignIn as SignIn
import Page.UI.SignUp as SignUp
import Style exposing (..)
import Styles exposing (..)


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : App.Model
    , discussions : Discussions.Model
    , signUp : SignUp.Model
    , signIn : SignIn.Model
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

        signInModel =
            SignIn.init
    in
        ( Model routing appModel discussionsModel signUpModel signInModel
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
    | SignIn SignIn.Msg


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

        SignIn subMessage ->
            let
                ( model', command ) =
                    SignIn.update subMessage model.signIn
            in
                { model | signIn = model' } ! [ Cmd.map SignIn command ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App (App.subscriptions model.app)



-- VIEWS


view : Model -> Html Msg
view model =
    let
        content =
            case model.routes.route of
                Root ->
                    topPage model

                Discussions subRoute ->
                    Html.map Discussion (Discussions.view subRoute model.discussions)

                NotFound ->
                    div [] [ h2 [] [ text "Not Found!" ] ]
    in
        div []
            [ navBar model
            , div [ style [ vspace 5 Style.em ] ] []
            , div [ class "container" ] [ content ]
            ]


navBar : Model -> Html Msg
navBar model =
    nav [ class "navbar navbar-full navbar-fixed-top navbar-light bg-faded" ]
        [ a [ class "navbar-brand", href "#/" ]
            [ text "Ask Code" ]
        , ul [ class "nav navbar-nav" ]
            [ item "Home" (Routing.Discussions Page.Index) model.routes.route
            ]
        , Html.form [ class "form-inline pull-xs-right" ]
            [ button [ class "btn btn-outline-primary", type' "button" ]
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
