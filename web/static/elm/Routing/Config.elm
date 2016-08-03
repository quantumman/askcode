module Routing.Config exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, matcherToPath, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation
import Routing.Page.Config as Page exposing (..)
import Routing.Page.Utility exposing (..)


-- ROUTES


type Route
    = Discussions Page.Route
    | SignIn
    | Root
    | NotFound


rootMatcher : PathMatcher Route
rootMatcher =
    match1 Root ""


topicsMatcher : PathMatcher Route
topicsMatcher =
    nested1 Discussions "/discussions" Page.matchers


signInMatcher : PathMatcher Route
signInMatcher =
    match1 SignIn "/sigin"


matchers : List (PathMatcher Route)
matchers =
    [ rootMatcher
    , topicsMatcher
    , signInMatcher
    ]


reverse : Route -> String
reverse route =
    case route of
        Root ->
            matcherToPath rootMatcher []

        Discussions subRoute ->
            topicsMatcher ./ subRoute

        SignIn ->
            matcherToPath signInMatcher []

        NotFound ->
            ""


routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFound
    }



-- MODEL


type alias Model =
    { location : Hop.Types.Location
    , route : Route
    }


make : ( Route, Hop.Types.Location ) -> Model
make ( route, location ) =
    Model location route



-- UPDATE


type alias Msg =
    Route


update : Msg -> Model -> ( Model, Cmd Msg )
update route model =
    let
        path =
            reverse route

        command =
            makeUrl routerConfig path
                |> Navigation.modifyUrl
    in
        ( model, command )


navigateTo : Msg -> Cmd Msg
navigateTo route =
    reverse route
        |> makeUrl routerConfig
        |> Navigation.modifyUrl



-- APP


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd a )
init ( route, location ) =
    ( Model location route, Cmd.none )
