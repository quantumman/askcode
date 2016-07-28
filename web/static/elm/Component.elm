module Component exposing (..)

-- UTILITIES
-- Inspired by Arrow Computation


first : (a -> b) -> ( a, c ) -> ( b, c )
first f ( x, y ) =
    ( f x, y )


second : (b -> c) -> ( a, b ) -> ( a, c )
second f ( x, y ) =
    ( x, f y )


infixr 3 ***
(***) : (a -> a') -> (b -> b') -> (( a, b ) -> ( a', b' ))
(***) f g =
    \v -> (first f v) |> second g


infixr 3 **!
(*>) : (a -> a') -> (b -> b') -> (( a, Cmd b ) -> ( a', Cmd b' ))
(*>) f g =
    \v -> (first f v) |> second (Cmd.map g)
