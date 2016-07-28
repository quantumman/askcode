module Http.Ext exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Task exposing (Task)


type alias ErrorMessage = String


post' : Decoder a -> String -> Encode.Value -> Task ErrorMessage a
post' decoder url payload =
    Http.send Http.defaultSettings
        { verb = "POST"
        , headers = [ ( "Content-Type", "application/json" ) ]
        , url = Http.url url []
        , body = Http.string (Encode.encode 0 payload)
        }
        |> Http.fromJson decoder
        |> Task.mapError errorToString


errorToString : Http.Error -> String
errorToString error =
    case error of
        Http.Timeout ->
            "TIMEOUT ERROR: Sorry, Our server might be too busy to process your request. Please try again a little while later."

        Http.NetworkError ->
            "You are offline. Please confirm your network status."

        Http.UnexpectedPayload e ->
            "UnexpectedPayload " ++ e

        Http.BadResponse code s ->
            if code == 401 then
                "Incorrect username or password. Please try again."
            else
                "BadResponse: " ++ (toString code) ++ " " ++ s
