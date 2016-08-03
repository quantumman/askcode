module Http.Session exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import LocalStorage exposing (..)
import Models exposing (..)
import Result exposing (Result)
import Task exposing (Task)


type alias Error = LocalStorage.Error


-- TASK


key : String
key =
    "session"


store : Credential -> Task x ()
store credential =
    encodeCredential credential
        |> Encode.encode 0
        |> set key


load : Task Error (Maybe Credential)
load =
    get key
        |> Task.map (Decode.decodeString decodeCredential)
        |> Task.map Result.toMaybe
