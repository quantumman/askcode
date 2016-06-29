module Main exposing (..)

import App
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Html exposing (..)
import Html.App as Html
import Navigation
import Routes.Config exposing (..)
import Topics.View as Topics


-- APP


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate router model =
    ( { model | routes = Routes.Config.make router }, Cmd.none )


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init router =
    let
        ( model, command ) =
            Routes.Config.init router

        ( appModel, appCommand ) =
            App.init

        commands =
            Cmd.batch [ command, Cmd.map App appCommand ]
    in
        ( Model (Routes.Config.make router) appModel, commands )


main : Program Never
main =
    Navigation.program Routes.Config.urlParser
        { init = init
        , view = dispatcher
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { routes : Routes.Config.Model
    , app : App.Model
    }



-- UPDATE


type Msg
    = NavigateTo Routes.Config.Msg
    | App App.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo subMessage ->
            let
                ( routes, command ) =
                    Routes.Config.update subMessage model.routes
            in
                ( { model | routes = routes }, Cmd.map NavigateTo command )

        App subMessage ->
            let
                ( app, command ) =
                    App.update subMessage model.app
            in
                ( { model | app = app }, Cmd.map App command )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App (App.subscriptions model.app)



-- VIEWS


dispatcher : Model -> Html Msg
dispatcher model =
    case model.routes.route of
        Topics subRoute ->
            Topics.view subRoute

        NotFound ->
            div [] [ h2 [] [ text "Not Found " ] ]
