module Routing.Config exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, matcherToPath, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation
import Routing.Page.Config as Page exposing (..)
import Routing.Page.Utility exposing (..)


-- ROUTES


type Route
    = Topics Page.Route
    | Root
    | NotFound


rootMatcher : PathMatcher Route
rootMatcher =
    match1 Root ""


topicsMatcher : PathMatcher Route
topicsMatcher =
    nested1 Topics "/topics" Page.matchers


matchers : List (PathMatcher Route)
matchers =
    [ rootMatcher
    , topicsMatcher
    ]


reverse : Route -> String
reverse route =
    case route of
        Root ->
            matcherToPath rootMatcher []

        Topics subRoute ->
            topicsMatcher ./ subRoute

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


type Msg
    = NavigateTo Route


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NavigateTo route ->
            let
                path =
                    reverse route

                command =
                    makeUrl routerConfig path
                        |> Navigation.modifyUrl
            in
                ( model, command )



-- APP


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd a )
init ( route, location ) =
    ( Model location route, Cmd.none )
