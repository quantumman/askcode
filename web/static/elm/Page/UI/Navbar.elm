module Page.UI.Navbar exposing (..)

import Component exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)
import Page.UI.Popover as Popover exposing (..)
import Routing.Config as Routing exposing (..)
import Routing.Page.Config as Page exposing (Route)


-- MODEL


type MenuId
    = Home


type alias Model =
    { menuId : MenuId
    , isLoggedIn : Bool
    , routes : Routing.Model
    , popover : Popover.Model
    , user : User
    }


init : Routing.Model -> Model
init r =
    { menuId = Home
    , isLoggedIn = False
    , routes = r
    , popover = Popover.init
    , user = { avatar = "", email = "" }
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
    | OpenMenuItem MenuId
    | Popover Popover.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        OpenMenuItem menuId ->
            { model | menuId = menuId } ! []

        NavigateTo subMessage ->
            Routing.update subMessage model.routes
                |> (\m -> { model | routes = m })
                *> NavigateTo

        Popover subMessage ->
            Popover.update subMessage model.popover
                |> (\m -> { model | popover = m })
                *> Popover



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
                (if model.isLoggedIn then
                    [ button
                        [ onClick <| Popover Popover.Toggle
                        , class "btn btn-outline-info"
                        , type' "button"
                        ]
                        [ text "Username" ]
                    , Popover.view model.popover
                        [ div [ class "container" ]
                            [ div [ class "row" ]
                                [ div [ class "col-xs-2 img-circle" ]
                                    [ img [ src model.user.avatar, alt "U" ] [] ]
                                , div [ class "col-xs-10" ]
                                    [ text "Username" ]
                                ]
                            ]
                        ]
                    ]
                 else
                    [ button
                        [ class "btn btn-outline-primary"
                        , type' "button"
                        , onClick (NavigateTo Routing.SignIn)
                        ]
                        [ text "Login" ]
                    ]
                )
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
            [ a [ class "nav-link", href <| getLink ref, onClick <| OpenMenuItem ref ]
                [ Html.text text ]
            ]
