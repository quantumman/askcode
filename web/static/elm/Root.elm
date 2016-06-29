module Root exposing (..)

import App
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Routing.Config as Routing exposing (..)
import Topics.View as Topics


-- MODEL


type alias Model =
    { routes : Routing.Model
    , app : AppModel
    }


type alias AppModel =
    { app : App.Model
    }


init : ( AppModel, Cmd Msg )
init =
    let
        ( appModel, appCommand ) =
            App.init
    in
        ( AppModel appModel, Cmd.map App appCommand )



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
                    App.update subMessage model.app.app

                appModel =
                    { app = app }
            in
                ( { model | app = appModel }, Cmd.map App command )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map App (App.subscriptions model.app.app)



-- VIEWS


view : Model -> Html Msg
view model =
    let
        content =
            case model.routes.route of
                Topics subRoute ->
                    Topics.view subRoute

                NotFound ->
                    div [] [ h2 [] [ text "Not Found!" ] ]
    in
        div [] [ navBar model, content ]


navBar : Model -> Html Msg
navBar model =
    let
        item t =
            li [ class "nav-item" ]
                [ a [ class "nav-link", href "#" ]
                    [ text t ]
                ]
    in
        nav [ class "navbar navbar-full navbar-light bg-faded" ]
            [ a [ class "navbar-brand", href "#" ]
                [ text "Ask Code" ]
            , ul [ class "nav navbar-nav" ]
                [ item "Home"
                ]
            , Html.form [ class "form-inline pull-xs-right" ]
                [ button [ class "btn btn-outline-primary", type' "button" ]
                    [ text "Login" ]
                ]
            ]
