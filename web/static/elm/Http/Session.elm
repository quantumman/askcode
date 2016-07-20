module Http.Session exposing (..)

import Json.Encode as Encode exposing (..)
import LocalStorage exposing (..)
import Models exposing (..)
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
