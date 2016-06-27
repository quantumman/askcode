module Routes.Page.Config exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, matcherToPath, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation


-- ROUTES


type Route
    = New
    | Edit Int
    | Index
    | Show Int
    | NotFound
