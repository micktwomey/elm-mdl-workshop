module Step02 exposing (..)

{-| Let's track some scores
-}

import Dict
import Html
import Html.Attributes
import List
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid as Grid
import Material.Layout
import Material.List as List
import Material.Options as Options
import Material.Scheme
import Material.Textfield as Textfield
import Material.Typography as Typography
import Regex


type alias Model =
    { machines : Dict.Dict Int Machine
    , mdl : Material.Model
    }


type alias Machine =
    { name : String
    , manufacturer : String
    , year : Int
    , genre : String
    , url : String
    , scores : List ( Int, String ) -- score -> name
    , newScore : Int
    , newScoreName : String -- There's a little bug here, Maybe String would be better
    }


init : ( Model, Cmd Msg )
init =
    { mdl = Material.model
    , machines =
        Dict.fromList
            [ ( 0, Machine "The Simpsons" "Konami" 1991 "Scrolling Fighter" "https://www.arcade-museum.com/game_detail.php?game_id=9550" [] 0 "" )
            , ( 1, Machine "Teenage Mutant Ninja Turtles" "Konami" 1989 "Scrolling Fighter" "https://www.arcade-museum.com/game_detail.php?game_id=10052" [] 0 "" )
            ]
    }
        ! [ Material.init MdlMsg ]


type Msg
    = MdlMsg (Material.Msg Msg)
    | AddScoreMsg Int
    | UpdateScoreMsg Int Int
    | UpdateNameMsg Int String


updateMachine : Model -> Int -> Maybe Machine -> ( Model, Cmd Msg )
updateMachine model index maybeMachine =
    case maybeMachine of
        Just machine ->
            { model | machines = Dict.insert index machine model.machines } ! []

        Nothing ->
            model ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MdlMsg mdlmsg ->
            Material.update MdlMsg mdlmsg model

        UpdateScoreMsg index score ->
            let
                maybeMachine =
                    Dict.get index model.machines

                maybeUpdatedMachine =
                    case maybeMachine of
                        Just machine ->
                            Just { machine | newScore = score }

                        Nothing ->
                            Nothing
            in
            updateMachine model index maybeUpdatedMachine

        UpdateNameMsg index name ->
            let
                maybeMachine =
                    Dict.get index model.machines

                maybeUpdatedMachine =
                    case maybeMachine of
                        Just machine ->
                            Just { machine | newScoreName = name }

                        Nothing ->
                            Nothing
            in
            updateMachine model index maybeUpdatedMachine

        AddScoreMsg index ->
            let
                maybeMachine =
                    Dict.get index model.machines

                maybeUpdatedMachine =
                    case maybeMachine of
                        Just machine ->
                            Just
                                { machine
                                    | scores =
                                        ( machine.newScore
                                        , machine.newScoreName
                                        )
                                            :: machine.scores
                                    , newScore = 0
                                    , newScoreName = ""
                                }

                        Nothing ->
                            Nothing
            in
            updateMachine model index maybeUpdatedMachine


{-| Check that rx matches all of str.

From <https://github.com/debois/elm-mdl/blob/master/demo/Demo/Textfields.elm#L147>

-}
match : String -> Regex.Regex -> Bool
match str rx =
    Regex.find Regex.All rx str
        |> List.any (.match >> (==) str)


{-| View a single machine as a MDL card

<https://debois.github.io/elm-mdl/#cards>

-}
viewMachine : Material.Model -> ( Int, Machine ) -> Html.Html Msg
viewMachine mdl ( index, machine ) =
    Card.view
        [ Elevation.e2
        ]
        [ Card.title [] [ Card.head [ Color.text Color.primary ] [ Html.text machine.name ] ]
        , Card.text [ Card.expand, Color.text Color.primary, Typography.headline ]
            [ List.ul []
                (List.map
                    (\( score, name ) -> List.li [] [ Html.text (toString score ++ " : " ++ name) ])
                    machine.scores
                )
            ]
        , Card.actions []
            [ Textfield.render MdlMsg
                [ 0 ]
                mdl
                [ Textfield.label "High score"

                -- We could also use a Maybe
                , Options.onInput (String.toInt >> Result.withDefault 0 >> UpdateScoreMsg index)
                , Textfield.value (toString machine.newScore)

                -- Note that this will never display due to oninput above
                , Textfield.error "Doesn't match [0-9]*"
                    |> Options.when (not <| match (toString machine.newScore) (Regex.regex "[0-9]*"))
                ]
                []
            , Textfield.render MdlMsg
                [ 1 ]
                mdl
                [ Textfield.label "Name"
                , Textfield.value machine.newScoreName
                , Options.onInput (UpdateNameMsg index)
                ]
                []
            , Button.render MdlMsg
                [ 2 ]
                mdl
                [ Button.raised
                , Button.colored
                , Options.onClick (AddScoreMsg index)
                ]
                [ Html.text "Submit Score" ]
            ]
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
                    -- Convert the dict to a list of (key, val) and then apply the viewMachine function
                    (Dict.toList model.machines |> List.map (viewMachine model.mdl))
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
