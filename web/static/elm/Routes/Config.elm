module Routes.Config exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation


-- ROUTES


type Route
    = Topics
    | Topic Int
    | NotFound
