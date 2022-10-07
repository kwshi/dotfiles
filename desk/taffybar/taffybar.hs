{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
--{-# LANGUAGE OverloadedRecordDot #-}
{-# OPTIONS_GHC -ilib #-}

module Main where

--import qualified System.Taffybar as Taffybar
--import System.Taffybar.Context (defaultTaffybarConfig)
--import qualified System.Taffybar.SimpleConfig as SC
--

import Control.Monad ((>=>))
import Control.Monad.Trans.Class (lift)
import qualified Data.Unique
import qualified GHC.Int
import GI.Gdk
import Graphics.UI.GIGtkStrut (StrutAlignment (..), StrutConfig (..), StrutPosition (..), StrutSize (..))
import qualified KS.Widget.Weather
import qualified StatusNotifier.Tray
import System.Taffybar
import System.Taffybar.Context (BarConfig (..), TaffybarConfig (..))
import qualified System.Taffybar.Context
import System.Taffybar.Information.CPU
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.Graph
import System.Taffybar.Widget.Generic.PollingGraph

cpuCallback =
  (\(_, systemLoad, totalLoad) -> [totalLoad, systemLoad]) <$> cpuLoad

barStrut :: GHC.Int.Int32 -> StrutPosition -> StrutConfig
barStrut monitor pos =
  StrutConfig
    { strutHeight = ExactSize 30,
      strutWidth = ScreenRatio 1,
      strutXPadding = 0,
      strutYPadding = 0,
      strutAlignment = Beginning,
      strutPosition = pos,
      strutMonitor = Just monitor,
      strutDisplayName = Nothing
    }

topBar :: Data.Unique.Unique -> GHC.Int.Int32 -> BarConfig
topBar barId monitor =
  BarConfig
    { strutConfig = barStrut monitor TopPos,
      widgetSpacing = 0,
      barId,
      startWidgets =
        [ workspacesNew $ defaultWorkspacesConfig {maxIcons = Just 0},
          windowsNew defaultWindowsConfig
        ],
      centerWidgets = [],
      endWidgets = []
    }

bottomBar :: Data.Unique.Unique -> GHC.Int.Int32 -> BarConfig
bottomBar barId monitor =
  BarConfig
    { strutConfig = barStrut monitor BottomPos,
      widgetSpacing = 0,
      barId,
      startWidgets =
        [ clock,
          KS.Widget.Weather.widget
        ],
      centerWidgets = [],
      endWidgets =
        [ System.Taffybar.Widget.sniTrayNewFromParams $
            StatusNotifier.Tray.defaultTrayParams
              { StatusNotifier.Tray.trayImageSize = StatusNotifier.Tray.TrayImageSize 22,
                StatusNotifier.Tray.trayIconExpand = False
              }
        ]
    }
  where
    clock =
      textClockNewWith $
        defaultClockConfig
          { clockFormatString = " %F (%A) %T %Z (%z) ",
            clockUpdateStrategy = RoundedTargetInterval 1 0
          }

manyBars :: (Data.Unique.Unique -> GHC.Int.Int32 -> BarConfig) -> [GHC.Int.Int32] -> IO [BarConfig]
manyBars f = mapM (withBarId f)

withBarId :: (Data.Unique.Unique -> GHC.Int.Int32 -> BarConfig) -> GHC.Int.Int32 -> IO BarConfig
withBarId f monitor = f <$> Data.Unique.newUnique <*> pure monitor

getBars :: IO [BarConfig]
getBars = do
  monitors <- getMonitors
  top <- manyBars topBar monitors
  bottom <- manyBars bottomBar monitors
  pure $ top <> bottom

main :: IO ()
main =
  dyreTaffybar $
    TaffybarConfig
      { dbusClientParam = Nothing,
        startupHook = pure (),
        getBarConfigsParam = lift getBars,
        cssPath = Nothing,
        errorMsg = Nothing
      }

getMonitors :: IO [GHC.Int.Int32]
getMonitors = do
  screen <- screenGetDefault
  monitorCount <- maybe (pure 0) (screenGetDisplay >=> displayGetNMonitors) screen
  pure [0 .. monitorCount - 1]
