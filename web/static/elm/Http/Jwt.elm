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


get : Decoder a -> String -> Task Error a
get decoder url =
    Session.load `andThen` (\{ jwt } -> Jwt.get jwt decoder url)


post : Decoder a -> String -> Encode.Value -> Task Error a
post decoder url payload =
    Session.load
        `andThen` (\{ jwt } ->
                    Jwt.post jwt decoder url
                        <| Http.string
                        <| (Encode.encode 0 payload)
                  )


put : Decoder a -> String -> Encode.Value -> Task Error a
put decoder url payload =
    let
        request { jwt } =
            Jwt.send "PUT" jwt decoder url
                <| Http.string
                <| Encode.encode 0 payload
    in
        Session.load `andThen` request


delete : String -> Task Error ()
delete url =
    let
        request { jwt } =
            Jwt.send "DELETE" jwt (Decode.null ()) url Http.empty
    in
        Session.load `andThen` request


patch : Decoder a -> String -> Encode.Value -> Task Error a
patch decoder url payload =
    let
        request { jwt } =
            Jwt.send "PATCH" jwt decoder url
                <| Http.string
                <| Encode.encode 0 payload
    in
        Session.load `andThen` request
