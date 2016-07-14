module Http.Ext exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Task exposing (Task)


post' : Decoder a -> String -> Encode.Value -> Task Http.Error a
post' decoder url payload =
    Http.send Http.defaultSettings
        { verb = "POST"
        , headers = [ ( "Content-Type", "application/json" ) ]
        , url = Http.url url []
        , body = Http.string (Encode.encode 0 payload)
        }
        |> Http.fromJson decoder
