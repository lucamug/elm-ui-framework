module FrameworkCustomized exposing (initConf, main, view, viewDocument)

import Browser
import Browser.Navigation
import Element exposing (alpha, column, el, link, moveLeft, none, paragraph, text)
import Element.Font as Font
import Framework
import FrameworkCustomized.Logo as Logo
import Html
import Url


main : Program Framework.Flags Framework.Model Framework.Msg
main =
    Browser.application
        { init = init
        , view = viewDocument
        , update = Framework.update
        , subscriptions = Framework.subscriptions
        , onUrlRequest = Framework.LinkClicked
        , onUrlChange = Framework.UrlChanged
        }


viewDocument : Framework.Model -> Browser.Document Framework.Msg
viewDocument =
    Framework.viewDocument


view : Framework.Model -> Html.Html Framework.Msg
view =
    Framework.view


init :
    Framework.Flags
    -> Url.Url
    -> Browser.Navigation.Key
    -> ( Framework.Model, Cmd Framework.Msg )
init flags url key =
    let
        initModel =
            Framework.initModel flags url key
    in
    ( { initModel
        | conf = initConf
        , introspections = introspections
      }
    , Framework.initCmd flags url key
    )


introspections : List ( Framework.Introspection, Bool )
introspections =
    ( Logo.introspection, True ) :: Framework.introspections


initConf : Framework.Conf msg
initConf =
    let
        confData =
            Framework.initConf

        title =
            column
                [ Font.family
                    [ Font.external
                        { name = "Archivo Black"
                        , url = "https://fonts.googleapis.com/css?family=Archivo+Black"
                        }
                    , Font.typeface "Archivo Black"
                    ]
                , Font.size 40
                ]
                [ link [ alpha 0.7 ] { label = Logo.logo Logo.LogoMassiveDynamics 120, url = ".." }
                , el [ moveLeft 3 ] <| text "Massive"
                , el [ moveLeft 3 ] <| text "Dynamics"
                ]
    in
    { confData
        | titleLeftSide = title
        , title = title
        , subTitle = "STYLE FRAMEWORK"
        , version = "0.19.0"
        , introduction =
            paragraph []
                [ text "This is a cutomized version of "
                , el [ Font.bold ] <| text "style-framework"
                , text "."
                ]
        , mainPadding = 41
        , password = ""
        , forkMe = Element.inFront <| none
        , hostnamesWithoutPassword = \_ -> True
    }
