module Page.Login exposing (..)

import Component exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Helpers as Html exposing (..)
import Page.UI.SignIn as SignIn


-- MODEL


type alias Model =
    { signIn : SignIn.Model
    }


init : Model
init =
    { signIn = SignIn.init
    }



-- UPDATE


type Msg
    = SignIn SignIn.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        SignIn subMessage ->
            SignIn.update subMessage model.signIn
                |> (\m -> { model | signIn = m })
                *> SignIn


update' : Msg -> { a | login : Model } -> (Msg -> msg) -> ( { a | login : Model }, Cmd msg )
update' message rootModel fmsg =
    let
        model =
            rootModel.login

        ( model', command ) =
            update message model
    in
        ( { rootModel | login = model' }, Cmd.map fmsg command )



-- VIEW


view : Model -> Html Msg
view model =
    let
        signIn =
            Html.map SignIn (SignIn.view model.signIn)
    in
        div []
            [ signIn ]
