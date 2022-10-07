module KS.Widget.Weather where

import Control.Monad.IO.Class (MonadIO)
import GI.Gtk.Objects.Widget (Widget)
import System.Taffybar.Widget

widget :: MonadIO m => m Widget
widget =
  weatherNew
    ( WeatherConfig
        { weatherStation = "KSMO",
          weatherTemplate = "$stationPlace$ $tempC$ °C",
          weatherTemplateTooltip = "",
          weatherFormatter = WeatherFormatter $ \w ->
            " "
              <> show (tempC w)
              <> " °C, "
              <> skyCondition w
              <> ", "
              <> show (humidity w)
              <> "% (as of "
              <> year w
              <> "-"
              <> month w
              <> "-"
              <> day w
              <> " "
              <> hour w
              <> ")",
          weatherProxy = Nothing
        }
    )
    1
