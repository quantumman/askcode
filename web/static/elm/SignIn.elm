module SignIn exposing (..)

import Http
import Http.Ext as Http exposing (..)
import Models exposing (..)
import Task exposing (Task)


-- MODEL


type alias Model =
    { email : String
    , password : String
    }



-- UPDATE


type Msg
    = SignIn
    | SignInSuccess Credential
    | SignInFail Http.Error
    | EmailOrUserName String
    | Password String


signIn : Model -> Cmd Msg
signIn model =
    let
        task =
            Http.post' decodeCredential
                "/api/sessions"
                (encodeUser model)
    in
        Task.perform SignInFail SignInSuccess task