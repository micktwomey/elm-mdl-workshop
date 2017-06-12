module Step01 exposing (main)

{-| Exercise 1: Let's handle lots of machines!

We can afford more machines!

-}

-- Html.blah is boring, lets bring in some stuff

import Html exposing (Html, div, h1, h2, li, text, ul)
import List


{-| Let's fill this in

TODO

-}
type alias Model =
    {}


{-| A single machine, the Model from Step 1
-}
type alias Machine =
    { name : String
    , manufacturer : String
    , year : Int
    , genre : String
    }



-- TODO Ask mick about more sophisticated modelling in Elm, we're not restricted to strings


{-| Helper to create a machine

We can also call `Machine "name" "manufacturer" year "genre", so this function isn't usually needed.

-}
machine : String -> String -> Int -> String -> Machine
machine name manufacturer year genre =
    { name = name
    , manufacturer = manufacturer
    , year = year
    , genre = genre
    }


{-| Create an instance of the model

TODO Fill this in too

-}
init : Model
init =
    {}


{-| Still a boring Msg
-}
type Msg
    = Nothing


{-| Still a boring update
-}
update : Msg -> Model -> Model
update msg model =
    -- Boring, we don't do anything!
    model


{-| Shows a single machine
-}
viewMachine : Machine -> Html Msg
viewMachine machine =
    div []
        [ h2 [] [ text machine.name ]
        , ul []
            [ li [] [ text ("Manufacturer: " ++ machine.manufacturer) ]

            -- TODO let's fill in more details
            ]
        ]


{-| This view will show a bunch of machines
-}
view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "ElmCade" ]

        -- TODO fill in the model!
        , div [] (List.map viewMachine [ machine "Foo" "Bar" 2017 "Eggs" ])
        ]



-- If you don't like brackets you can do this: (yay pipes!)
-- , List.map viewMachine [ machine "Foo" "Bar" 2017 "Eggs" ]
--     |> div []


{-| Run it!
-}
main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
