module Main exposing (..)

import App
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Html exposing (..)
import Html.App as Html
import Navigation
import Routes.Config exposing (..)


-- MODEL


type alias Model =
    { routes : Routes.Config.Model
    , app : App.Model
    }



-- UPDATE


type Msg
    = NavigateTo Route
    | App App.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo route ->
            let
                path =
                    reverse route

                command =
                    makeUrl routerConfig path
                        |> Navigation.modifyUrl
            in
                ( model, command )

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
        Topics ->
            div []
                [ Html.map App (App.view model.app)
                ]

        Topic id ->
            div [] [ h2 [] [ text "Temporary View" ] ]

        NotFound ->
            div [] [ h2 [] [ text "Not Found " ] ]



-- APP


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate router model =
    ( { model | routes = Routes.Config.make router }, Cmd.none )


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init router =
    let
        ( model, command ) =
            Routes.Config.init router

        ( route, location ) =
            ( model.route, model.location )
    in
        ( Model (Routes.Config.make router) App.init, command )


main : Program Never
main =
    Navigation.program Routes.Config.urlParser
        { init = init
        , view = dispatcher
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
