module Page.UI.Navbar exposing (..)

import Component exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)


-- MODEL


type MenuId
    = Home


type alias Model =
    { menuId : MenuId
    , isLoggedIn : Bool
    , routes : Routing.Model
    }


getLink : MenuId -> String
getLink menuId =
    let
        route =
            case menuId of
                Home ->
                    Routing.Discussions Page.Index
    in
        "/#" ++ Routing.reverse route



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


view : Model -> List MenuItem -> Html Msg
view model menuItems =
    let
        menuItemViews =
            List.map (\m -> m model.menuId) menuItems
    in
        nav [ class "navbar navbar-full navbar-fixed-top navbar-light bg-faded" ]
            [ a [ class "navbar-brand", href "#/" ]
                [ text "Ask Code" ]
            , ul [ class "nav navbar-nav" ] menuItemViews
            , Html.form [ class "form-inline pull-xs-right" ]
                [ button
                    [ class "btn btn-outline-primary"
                    , type' "button"
                    , onClick (NavigateTo Routing.SignIn)
                    ]
                    [ text "Login" ]
                ]
            ]


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
