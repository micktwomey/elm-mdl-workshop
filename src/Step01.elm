module Step01 exposing (..)

{-| Step 1: Let's define a model

We're running an Arcade Bar and we need to track our machines.

We can only afford one so far.

-}

import Html


{-| The model is how we track state of the app, everthing goes in here. No sneak side effects for us!
-}
type alias Model =
    { name : String
    , manufacturer : String
    , year : Int
    , genre : String
    }


{-| Create an instance of the model

Every Elm app needs something like this to start things off

-}
init : Model
init =
    -- Details from https://www.arcade-museum.com/game_detail.php?game_id=9550
    { name = "The Simpsons"
    , manufacturer = "Konami"
    , year = 1991
    , genre = "Scrolling Fighter"
    }


{-| Msg is how we figure out what we're doing in updates, this one is super boring!
-}
type Msg
    = Nothing


{-| Update is the only place we update stuff

We get a Msg, a model and return a model + any actions we want to take

-}
update : Msg -> Model -> Model
update msg model =
    -- Boring, we don't do anything!
    model


{-| view is where we show stuff
-}
view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "ElmCade" ]
        , Html.h2 [] [ Html.text model.name ]
        , Html.pre [] [ Html.text (toString model) ]
        ]


{-| Finally, we need to run stuff!

beginnerProgram omits some parts (Cmd output of update and subscriptions), we'll see those later

-}
main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
