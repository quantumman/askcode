module Root exposing (..)

import App
import Discussions
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)
import Style exposing (..)
import Styles exposing (..)


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : App.Model
    , topics : Discussions.Model
    }


init : Routing.Model -> ( Model, Cmd Msg )
init routing =
    let
        ( appModel, appCommand ) =
            App.init

        topicsModel =
            Discussions.init
    in
        ( Model routing appModel topicsModel, Cmd.map App appCommand )



-- UPDATE


type Msg
    = NavigateTo Routing.Msg
    | App App.Msg
    | Discussion Discussions.Msg


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
                    Discussions.update subMessage model.topics
            in
                ( { model | topics = model' }, Cmd.map Discussion command )



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
                    Discussions.view (Page.Index) model.topics

                Discussions subRoute ->
                    Discussions.view subRoute model.topics

                NotFound ->
                    div [] [ h2 [] [ text "Not Found!" ] ]
    in
        div []
            [ navBar model
            , div [ style [ vspace 1 Style.em ] ] []
            , div [ class "container" ]
                [ Html.map Discussion content ]
            ]


navBar : Model -> Html Msg
navBar model =
    nav [ class "navbar navbar-full navbar-light bg-faded" ]
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
