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
    Cmd msg


type alias OnRemoveDom msg =
    Cmd msg


type Msg
    = AddDom Id
    | RemoveDom Id


update : Msg -> OnAddDom msg -> OnRemoveDom msg -> Id -> Cmd msg
update message onAddDom onRemoveDom model =
    case message of
        AddDom id ->
            if id == model then
                Cmd.batch
                    [ onAddDom
                    , disconnect model
                    ]
            else
                Cmd.none

        RemoveDom id ->
            if id == model then
                Cmd.batch
                    [ onRemoveDom
                    , observe model
                    ]
            else
                Cmd.none



-- SUBSCRIPTION


port addDom : (Id -> msg) -> Sub msg


port removeDom : (Id -> msg) -> Sub msg


subscriptions : (Msg -> msg) -> Sub msg
subscriptions sub =
    Sub.map sub
        (Sub.batch
            [ addDom AddDom
            , removeDom RemoveDom
            ]
        )
