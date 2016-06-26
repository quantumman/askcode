port module Ace exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Style
import Html.Dom as Dom


-- MODEL


type alias Model =
    { code : String
    , id : Dom.Id
    }


init : Dom.Id -> ( Model, Cmd Msg )
init id =
    ( { code = "", id = id }, (Dom.init id) )



-- UPDATE


port initialize : ( Dom.Id, String ) -> Cmd msg


port destroy : Dom.Id -> Cmd msg


type Msg
    = Change ( Dom.Id, String )
    | Dom Dom.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change ( id, code ) ->
            let
                model' =
                    if id == model.id then
                        { model | code = code }
                    else
                        model
            in
                ( model', Cmd.none )

        Dom subMessage ->
            let
                command =
                    Dom.update subMessage
                        (initialize ( model.id, model.code ))
                        (destroy model.id)
                        model.id
            in
                ( model, command )



-- SUBSCRIPTION


port change : (( Dom.Id, String ) -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ change Change
        , Dom.subscriptions Dom
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ id model.id
        , style [ Style.height (Style.em 20) ]
        ]
        []
