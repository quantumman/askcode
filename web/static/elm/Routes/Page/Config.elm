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


newMatcher : PathMatcher Route
newMatcher =
    match1 New "/new"


editMatcher : PathMatcher Route
editMatcher =
    match2 Edit "/edit/" int


indexMatcher : PathMatcher Route
indexMatcher =
    match1 Index ""


showMatcher : PathMatcher Route
showMatcher =
    match2 Show "/show/" int


matchers : List (PathMatcher Route)
matchers =
    [ newMatcher
    , editMatcher
    , indexMatcher
    , showMatcher
    ]
