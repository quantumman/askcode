module Page.UI.Alert exposing (..)

-- MODEL


type Model
    = Success String
    | Info String
    | Warning String
    | Error String
    | Note String
    | Dismiss


init : Model
init =
    Dismiss
