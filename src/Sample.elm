module Sample exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)



-- Main


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    String


type Msg
    = Click


init : Model
init =
    "Hello World!"



-- Update


update : Msg -> Model -> String
update _ model =
    case model of
        "Hello World!" ->
            "Cicked"

        _ ->
            "Hello World!"


setBackground : Model -> String
setBackground model =
    case model of
        "Hello World!" ->
            "cyan"

        _ ->
            "red"



-- View


view : Model -> Html Msg
view model =
    div
        [ style "background-color" (setBackground model)
        , style "position" "absolute"
        , style "top" "0"
        , style "right" "0"
        , style "bottom" "0"
        , style "left" "0"
        , style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        ]
        [ text model
        , button
            [ onClick Click
            , style "margin-left" "10px"
            ]
            [ text "Click Me!" ]
        ]
