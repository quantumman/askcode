module Styles exposing (..)

import Style exposing (..)


vspace : number -> (number -> String) -> Style
vspace n unit =
    unit n |> marginBottom
