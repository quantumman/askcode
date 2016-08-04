module Page.UI.Navbar exposing (..)

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
