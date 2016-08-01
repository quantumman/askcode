module View.Form exposing (..)

import Form exposing (Form)
import Form.Input as Input
import Form.Validate as Validate exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Events.Ext exposing (..)


form : List (Html Form.Msg) -> Html Form.Msg
form =
    Html.form [ onEnter Form.NoOp Form.Submit ]


type alias Input error model field =
    { type'' : String
    , getField : String -> Form error model -> Form.FieldState error field
    , inputTag : Form.FieldState error field -> List (Html.Attribute Form.Msg) -> Html Form.Msg
    }


makeInput : Input e m b -> Form e m -> String -> String -> Maybe String -> Html Form.Msg
makeInput { type'', getField, inputTag } form id' label' placeholder' =
    let
        validationFor { liveError } =
            case liveError of
                Just error ->
                    ( "has-danger"
                    , "form-control-danger"
                    , div [ class "form-control-feedback" ] [ text <| toString error ]
                    )

                Nothing ->
                    ( "", "", text "" )

        field =
            getField id' form

        ( formGroupClass, inputClass, error ) =
            validationFor field
    in
        fieldset [ class ("form-group " ++ formGroupClass) ]
            [ label [ for id' ] [ text label' ]
            , inputTag field
                [ class ("form-control " ++ inputClass)
                , id id'
                , placeholder (Maybe.withDefault "" placeholder')
                , type' type''
                ]
            , error
            ]


input : Input e m b -> Form e m -> String -> String -> String -> Html Form.Msg
input a b c d placeholder =
    makeInput a b c d (Just placeholder)


input' : Input e m b -> Form e m -> String -> String -> Html Form.Msg
input' a b c d =
    makeInput a b c d Nothing
