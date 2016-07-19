module Page.Login exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Helpers as Html exposing (..)
import Page.UI.SignIn as SignIn


-- MODEL


type alias Model =
    { signIn : SignIn.Model
    }



-- UPDATE


type Msg
    = SignIn SignIn.Msg


update : Msg -> Model -> Cmd Msg
update message model =
    case message of
        SignIn subMessage ->
            let
                ( _, subCommand ) =
                    SignIn.update subMessage model.signIn
            in
                Cmd.map SignIn subCommand



-- VIEW


view : Model -> Html Msg
view model =
    let
        signIn =
            Html.map SignIn (SignIn.view model.signIn)
    in
        div []
            [ signIn ]
