module Page.UI.Navbar exposing (..)

import Component exposing (..)
import Routing.Config as Routing exposing (..)


-- MODEL


type MenuId
    = Home


type alias Model =
    { menuId : MenuId
    , isLoggedIn : Bool
    , routes : Routing.Model
    }



-- UPDATE


type Msg
    = NavigateTo Routing.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NavigateTo subMessage ->
            Routing.update subMessage model.routes
                |> (\m -> { model | routes = m })
                *> NavigateTo
