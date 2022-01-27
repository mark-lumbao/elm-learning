module RandomInt exposing (..)

import Browser
import Html exposing (Html, div, text)
import Random


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    Int


type Msg
    = NewInt Model


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0
    , Random.generate NewInt (Random.int 0 10)
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        NewInt randomInt ->
            ( randomInt, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text "Randomly Generated Number: "
        , text (String.fromInt model)
        ]
