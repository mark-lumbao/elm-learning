module Form exposing (..)

import Browser
import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- State


type alias Model =
    { username : String, password : String, submitted : Bool }


init : Model
init =
    { username = ""
    , password = ""
    , submitted = False
    }



-- Update


type Msg
    = Submit
    | Reset
    | ChangeUName String
    | ChangePWord String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Submit ->
            { model | submitted = True }

        ChangeUName value ->
            { model | username = value }

        ChangePWord value ->
            { model | password = value }

        _ ->
            { model | username = "", password = "", submitted = False }



-- View


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "gap" "5px"
        , style "max-width" "300px"
        , style "padding" "5px"
        ]
        [ input [ value model.username, onInput ChangeUName, placeholder "Username" ] []
        , input [ value model.password, onInput ChangePWord, type_ "password", placeholder "Password" ] []
        , button [ style "display" (showMessage (not model.submitted)), onClick Submit ] [ text "Submit" ]
        , button [ style "display" (showMessage model.submitted), onClick Reset ] [ text "Reset" ]
        , span [ style "display" (showMessage model.submitted) ] [ text ("Submitted " ++ model.username) ]
        ]



-- Utils


showMessage : Bool -> String
showMessage arg =
    if arg then
        "block"

    else
        "none"
