module UserFetch exposing (main)

import Browser
import Html exposing (Html, br, div, h1, li, text, ul)
import Html.Attributes exposing (style)
import Http
import Json.Decode exposing (Decoder, field, list, map3, map4, string)
import List exposing (map)



-- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias User =
    { name : Name
    , picture : Picture
    , gender : String
    , email : String
    }


type alias Name =
    { title : String
    , last : String
    , first : String
    }


type alias Picture =
    { large : String
    , medium : String
    , thumbnail : String
    }


type alias Users =
    List User


type Model
    = Loading
    | Failure
    | Success Users


type Msg
    = GotUser (Result Http.Error Users)



-- Init


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://randomuser.me/api/?results=10"
        , expect = Http.expectJson GotUser resultsDecoder
        }
    )


resultsDecoder : Decoder Users
resultsDecoder =
    field "results" (list usersDecoder)


usersDecoder : Decoder User
usersDecoder =
    map4 User
        (field "name" nameDecoder)
        (field "picture" pictureDecoder)
        (field "gender" string)
        (field "email" string)


nameDecoder : Decoder Name
nameDecoder =
    map3 Name
        (field "title" string)
        (field "last" string)
        (field "first" string)


pictureDecoder : Decoder Picture
pictureDecoder =
    map3 Picture
        (field "large" string)
        (field "medium" string)
        (field "thumbnail" string)



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotUser res ->
            case res of
                Ok users ->
                    ( Success users, Cmd.none )

                _ ->
                    ( Loading, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [ style "margin" "0" ] [ text "List of Random Users" ]
        , br [] []
        , case model of
            Loading ->
                text "Loading User"

            Failure ->
                text "Failed to load User"

            Success users ->
                ul [] (map (\u -> li [] [ text u.name.first ]) users)
        ]
