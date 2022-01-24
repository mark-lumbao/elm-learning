module HttpExample exposing (..)

-- Module imports

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Http exposing (Error)



-- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type Model
    = Loading
    | Failure
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }
    )



-- Update


type Msg
    = GotText (Result Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotText res ->
            case res of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


content : Model -> Html Msg
content model =
    case model of
        Loading ->
            text "Loading"

        Failure ->
            text "Failed to Load asset"

        Success fullText ->
            text fullText



-- View


view : Model -> Html Msg
view model =
    div
        [ style "height" "100vh"
        , style "width" "100vw"
        ]
        [ div
            [ style "display" "flex"
            , style "justify-content" "center"
            , style "align-items" "center"
            , style "width" "100%"
            , style "height" "100%"
            ]
            [ content model ]
        ]
