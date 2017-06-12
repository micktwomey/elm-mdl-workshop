module Step02 exposing (..)

{-| Let's make it prettier!
-}

import Html
import Html.Attributes
import Material
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid as Grid
import Material.Layout
import Material.List as List
import Material.Scheme
import Material.Typography as Typography


type alias Model =
    { machines : List Machine
    , mdl : Material.Model
    }


type alias Machine =
    { name : String
    , manufacturer : String
    , year : Int
    , genre : String
    }


init : ( Model, Cmd Msg )
init =
    { mdl = Material.model
    , machines =
        [ -- https://www.arcade-museum.com/game_detail.php?game_id=9550
          Machine "The Simpsons" "Konami" 1991 "Scrolling Fighter"

        -- https://www.arcade-museum.com/game_detail.php?game_id=10052
        , Machine "Teenage Mutant Ninja Turtles" "Konami" 1989 "Scrolling Fighter"
        ]
    }
        ! [ Material.init MdlMsg ]


type Msg
    = MdlMsg (Material.Msg Msg)
    | BoringMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    -- Pattern match to victory
    case msg of
        MdlMsg mdlmsg ->
            Material.update MdlMsg mdlmsg model

        BoringMsg ->
            model ! []


{-| View a single machine as a MDL card

<https://debois.github.io/elm-mdl/#cards>

-}
viewMachine : Machine -> Html.Html Msg
viewMachine machine =
    Card.view
        [ Elevation.e2
        ]
        [ Card.title [] [ Card.head [ Color.text Color.primary ] [ Html.text machine.name ] ]
        , Card.text [ Card.expand, Color.text Color.primary, Typography.headline ]
            [ List.ul []
                [ List.li [] [ Html.text machine.manufacturer ]
                ]
            ]
        , Card.actions [] []
        ]


{-| view with Material.Scheme.top + debug fix for local dev

Fix from <https://github.com/debois/elm-mdl/issues/270#issuecomment-291643488>

-}
viewWithScheme : Model -> Html.Html Msg
viewWithScheme model =
    Html.div [] <|
        [ Html.node "style"
            [ Html.Attributes.type_ "text/css" ]
            [ Html.text <| ".elm-overlay { z-index: 999; }" ]
        , Material.Scheme.top <| view model
        ]


{-| Let's show the machine
-}
view : Model -> Html.Html Msg
view model =
    Material.Layout.render MdlMsg
        model.mdl
        []
        { header = []
        , drawer = []
        , tabs = ( [], [] )
        , main =
            -- MDL uses a grid system for la
            -- https://debois.github.io/elm-mdl/#grid
            [ Grid.grid
                [ Grid.size Grid.All 6 ]
                [ Grid.cell [ Grid.size Grid.All 2 ]
                    [ viewMachine (Machine "Teenage Mutant Ninja Turtles" "Konami" 1989 "Scrolling Fighter")
                    ]
                ]
            ]
        }


{-| Subscriptions handle events like keyboard input and websokets, we want MDL ones here
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions MdlMsg model


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = viewWithScheme
        , subscriptions = subscriptions
        }
