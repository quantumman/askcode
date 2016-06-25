port module Html.Dom exposing (..)

-- UPDATE


port observe : Id -> Cmd msg


port disconnect : Id -> Cmd msg



-- SUBSCRIPTION


port addDom : (Id -> msg) -> Sub msg


port removeDom : (Id -> msg) -> Sub msg
