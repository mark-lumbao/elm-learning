module Application exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (href, style)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    let
        link url label =
            a
                [ href url
                , style "color" "teal"
                ]
                [ text ("Visit " ++ label) ]

        brk =
            br [] []

        str txt =
            p [ style "color" "teal" ]
                [ h1 [ style "margin-bottom" "0px" ] [ text "Right now you're at: " ]
                , i [] [ text txt ]
                ]
    in
    { title = "M-A-L"
    , body =
        [ div [ style "padding" "2rem" ]
            [ link "/home" "Home"
            , brk
            , link "/profile" "Profile"
            , str model.url.path
            , brk
            , brk
            ]
        ]
    }
