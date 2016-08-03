module Http.Jwt exposing (..)

import Http
import Http.Extra exposing (..)
import Http.Session as Session exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Jwt exposing (..)
import Models exposing (..)
import Task exposing (Task)


type Error
    = SessionError Session.Error
    | EmptySessionError String
    | HttpError Http.Error


andThen : Task Session.Error (Maybe Credential) -> (Credential -> Task Http.Error a) -> Task Error a
andThen m f =
    let
        m' =
            Task.mapError SessionError m

        jwt' =
            Task.fromMaybe (EmptySessionError "Credential is empty")

        f' x =
            Task.mapError HttpError (f x)
    in
        m' `Task.andThen` jwt' `Task.andThen` f'
