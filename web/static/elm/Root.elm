module Root exposing (..)

import App
import Html exposing (..)
import Html.App as Html
import Routing.Config as Routing exposing (..)
import Topics.View as Topics


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : App.Model
    }


init : ( App.Model, Cmd App.Msg )
init =
    App.init



-- UPDATE


type Msg
    = NavigateTo Routing.Msg
    | App App.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo subMessage ->
            let
                ( routes, command ) =
                    Routing.update subMessage model.routes
            in
                ( { model | routes = routes }, Cmd.map NavigateTo command )

        App subMessage ->
            let
                ( app, command ) =
                    App.update subMessage model.app
            in
                ( { model | app = app }, Cmd.map App command )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App (App.subscriptions model.app)



-- VIEWS


view : Model -> Html Msg
view model =
    case model.routes.route of
        Topics subRoute ->
            Topics.view subRoute

        NotFound ->
            div [] [ h2 [] [ text "Not Found " ] ]
