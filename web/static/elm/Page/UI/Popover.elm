module Page.UI.Popover exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Style exposing (..)
import Styles exposing (..)


-- MODEL


type alias Model =
    { isOpened : Bool
    }



-- UPDATE


type Msg
    = Open
    | Close



--- STYLE


popover : List Style
popover =
    [ position absolute
    , top "100%"
    , right "0"
    , zIndex "100"
    , marginLeft "-10em"
    , display block
    , width <| Style.em 20
    , padding <| Style.em 0.3
    , ( "word-wrap", "break-word" )
    , ( "background-clip", "padding-box" )
    , border "1px solid #EEEEEE"
    , backgroundColor "#FFFFFF"
    , borderRadius "5px 5px 5px 5px"
    ]
