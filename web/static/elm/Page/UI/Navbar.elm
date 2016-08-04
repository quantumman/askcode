module Page.UI.Navbar exposing (..)

import Component exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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



-- VIEWS


type alias MenuItem =
    MenuId -> Html Msg


menuItem : String -> MenuId -> MenuItem
menuItem text ref current =
    let
        active =
            if ref == current then
                "active"
            else
                ""
    in
        li [ class ("nav-item " ++ active) ]
            [ a [ class "nav-link", href ("/#") ]
                [ Html.text text ]
            ]
