module Routing.Page.Utility exposing (..)

import Hop exposing (matcherToPath)
import Hop.Types exposing (PathMatcher)
import Routing.Page.Config exposing (..)
import Navigation


(./) : PathMatcher route -> Route -> String
(./) parentMatcher route =
    let
        parentPath =
            matcherToPath parentMatcher []

        path =
            reverse route
    in
        parentPath ++ path
