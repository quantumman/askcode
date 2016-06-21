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


topicsMatcher : PathMatcher Route
topicsMatcher =
    match1 Topics "/topics"


topicMatcher : PathMatcher Route
topicMatcher =
    match2 Topic "/topics/" int
