module TimeExample exposing (..)

import Browser
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (style)
import Task
import Time


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { zone : Time.Zone
    , time : Time.Posix
    }


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


containerStyle : List (Attribute msg)
containerStyle =
    [ style "color" "grey"
    , style "display" "flex"
    , style "justify-content" "center"
    , style "align-items" "center"
    , style "position" "fixed"
    , style "top" "0"
    , style "bottom" "0"
    , style "left" "0"
    , style "right" "0"
    , style "font-size" "30px"
    ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | time = time }
            , Cmd.none
            )

        AdjustTimeZone zone ->
            ( { model | zone = zone }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick


view : Model -> Html Msg
view model =
    let
        hour =
            String.fromInt (Time.toHour model.zone model.time)

        minute =
            String.fromInt (Time.toMinute model.zone model.time)

        seconds =
            String.fromInt (Time.toSecond model.zone model.time)
    in
    div containerStyle
        [ text hour
        , text ":"
        , text minute
        , text ":"
        , text seconds
        ]
