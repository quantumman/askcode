module Http.Session exposing (..)

import LocalStorage exposing (..)
import Models exposing (..)


-- MESSAGE


type Msg
    = StoreSuccess ()
    | StoreFail Error
    | LoadSuccess (Maybe Credential)
    | LoadFail Error
