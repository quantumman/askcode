module Main exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation
import Root exposing (..)
import Routing.Config exposing (urlParser, init, make, Route)


-- APP


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate router model =
    ( { model | routes = Routing.Config.make router }, Cmd.none )


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init router =
    let
        ( model, command ) =
            Routing.Config.init router

        ( rootModel, rootCommand ) =
            Root.init

        commands =
            Cmd.batch [ command, rootCommand ]
    in
        ( Model (Routing.Config.make router) rootModel, commands )


main : Program Never
main =
    Navigation.program Routing.Config.urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
