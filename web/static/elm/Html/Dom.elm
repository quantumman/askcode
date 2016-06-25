port module Html.Dom exposing (..)

-- MODEL


type alias Id =
    String


init : Id -> Cmd msg
init id =
    observe id



-- UPDATE


port observe : Id -> Cmd msg


port disconnect : Id -> Cmd msg


type alias OnAddDom msg =
    Id -> Cmd msg


type alias OnRemoveDom msg =
    Id -> Cmd msg


type Msg
    = AddDom Id
    | RemoveDom Id



-- SUBSCRIPTION


port addDom : (Id -> msg) -> Sub msg


port removeDom : (Id -> msg) -> Sub msg
