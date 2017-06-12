module Main exposing (..)

import Html exposing (Html, li, ul, code, text, div, h1, button)
import Html.Events exposing (onClick)
import Navigation
import UrlParser as Url exposing ((</>), (<?>), s, int, stringParam, top)


type alias Model =
    { history : List (Maybe Route)
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model [ Url.parsePath route location ]
    , Cmd.none
    )


type Route
    = Home



--   | BlogList (Maybe String)
--   | BlogPost Int


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home top

        -- , Url.map BlogList (s "blog" <?> stringParam "search")
        -- , Url.map BlogPost (s "blog" </> int)
        ]


type Msg
    = NewUrl String
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model
            , Navigation.newUrl url
            )

        UrlChange location ->
            ( { model | history = Url.parseHash route location :: model.history }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Links" ]
        , ul [] (List.map viewLink [ "#/", "#/blog/", "#/blog/42", "#/blog/37", "#/blog/?search=cats" ])
        , h1 [] [ text "History" ]
        , ul [] (List.map viewRoute model.history)
        ]


viewLink : String -> Html Msg
viewLink url =
    li [] [ button [ onClick (NewUrl url) ] [ text url ] ]


viewRoute : Maybe Route -> Html msg
viewRoute maybeRoute =
    case maybeRoute of
        Nothing ->
            li [] [ text "Invalid URL" ]

        Just route ->
            li [] [ code [] [ text (routeToString route) ] ]


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            "home"



-- BlogList Nothing ->
--     "list all blog posts"
-- BlogList (Just search) ->
--     "search for " ++ Http.encodeUri search
-- BlogPost id ->
--     "show blog " ++ toString id


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
