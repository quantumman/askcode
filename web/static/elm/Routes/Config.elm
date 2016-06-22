module Routes.Config exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, matcherToPath, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation


-- ROUTES


type Route
    = Topics
    | Topic Int
    | NotFound


topicsMatcher : PathMatcher Route
topicsMatcher =
    match1 Topics "/topics"


topicMatcher : PathMatcher Route
topicMatcher =
    match2 Topic "/topics/" int


matchers : List (PathMatcher Route)
matchers =
    [ topicsMatcher
    , topicMatcher
    ]


reverse : Route -> String
reverse route =
    case route of
        Topics ->
            matcherToPath topicsMatcher []

        Topic id ->
            matcherToPath topicMatcher [ toString id ]

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
