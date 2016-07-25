module Http.Session exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import LocalStorage exposing (..)
import Models exposing (..)
import Result exposing (Result)
import Task exposing (Task)


-- MESSAGE


type Msg
    = StoreSuccess ()
    | StoreFail Error
    | LoadSuccess (Maybe Credential)
    | LoadFail Error



-- TASK


key : String
key =
    "session"


store : (Msg -> msg) -> Credential -> Cmd msg
store fmsg credential =
    encodeCredential credential
        |> Encode.encode 0
        |> set key
        |> Task.perform StoreFail StoreSuccess
        |> Cmd.map fmsg


load : (Msg -> msg) -> Cmd msg
load fmsg =
    get key
        |> Task.map (Decode.decodeString decodeCredential)
        |> Task.map Result.toMaybe
        |> Task.perform LoadFail LoadSuccess
        |> Cmd.map fmsg
