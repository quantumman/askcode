module Component exposing (..)

-- UTILITIES
-- Inspired by Arrow Computation


first : (a -> b) -> ( a, c ) -> ( b, c )
first f ( x, y ) =
    ( f x, y )


second : (b -> c) -> ( a, b ) -> ( a, c )
second f ( x, y ) =
    ( x, f y )
