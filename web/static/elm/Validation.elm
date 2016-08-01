module Validation exposing (..)

import Html exposing (..)
import Form.Error as Error exposing (..)


validationMessageFor : String -> Maybe v -> Error a -> Html msg
validationMessageFor fieldname value error =
    let
        message =
            case error of
                GroupErrors errorDict ->
                    ""

                Empty ->
                    "You must enter " ++ fieldname

                InvalidString ->
                    fieldname ++ " is invalid"

                InvalidEmail ->
                    "You must enter valid emaild address \n e.g. foobar@askcode.co.jp"

                InvalidUrl ->
                    "You must enter valid url \n e.g. https://askcode.co.jp/top"

                InvalidFormat ->
                    fieldname ++ " is invalid format"

                InvalidInt ->
                    "You must enter valid number \n e.g. 777"

                InvalidFloat ->
                    "You must enter valid number \n e.g. 7.77"

                InvalidBool ->
                    "You must choose one of " ++ fieldname ++ " at least"

                InvalidDate ->
                    "You must enter valid datetime \n e.g 2016/08/01"

                SmallerIntThan n ->
                    "You must enter greater than " ++ (toString n)

                GreaterIntThan n ->
                    "You must enter smaller than " ++ (toString n)

                SmallerFloatThan n ->
                    "You must enter greater than " ++ (toString n)

                GreaterFloatThan n ->
                    "You must enter greater than " ++ (toString n)

                ShorterStringThan n ->
                    "You must enter longer than " ++ (toString n) ++ " characters"

                LongerStringThan n ->
                    "You must enter shorter than " ++ (toString n) ++ " characters"

                NotIncludedIn ->
                    "You must choose an item from " ++ fieldname

                CustomError e ->
                    ""
    in
        text message
