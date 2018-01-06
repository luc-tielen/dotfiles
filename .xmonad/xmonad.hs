
module Main where

-- Imports
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Operations (kill)
import XMonad.Actions.CycleWS (prevWS, nextWS)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..))
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Hooks.DynamicLog (xmobarPP, xmobarColor)
import XMonad.Hooks.DynamicLog (ppOutput, ppTitle, ppCurrent, ppSep, ppUrgent, ppLayout)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, shorten, wrap)
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts, docks)
import System.IO


-- Configuration:

myKeyBindings :: XConfig Layout -> [(String, X ())]
myKeyBindings conf =
  [ -- Keybindings for window management:
    ("M-q", kill)                                 -- kill focused app
  , ("M-<Space>", sendMessage NextLayout)         -- toggles tiling layout
  , ("M-S-<Space>", setLayout $ layoutHook conf)  -- resets window layout to default
  , ("M-<Tab>", windows W.focusDown)              -- Move focus to next window
  , ("M-S-<Tab>", windows W.focusUp)              -- Move focus to prev window
  -- Some keybindings for quickly opening often used programs:
  , ("M-<Return>", spawn $ terminal conf)
  , ("M-c", spawn "chromium")
  , ("M-e", spawn "emacs")
  -- TODO +- volume, mute, switching workspaces, scrot, ...
  ]
  ++
  [("M-" ++ show num, windows $ f wsId)
    | (wsId, num) <- zip (workspaces conf) [1..9]
    , f <- [W.greedyView, W.shift]
  ]
  ++
  [ ("M-<KP_Left>", prevWS), ("M-<KP_Right>", nextWS) ]

myWorkSpaces :: [WorkspaceId]
myWorkSpaces = ["WEB", "CODE", "CHAT", "OTHER"]

myLayouts = tallLayout ||| Mirror tallLayout ||| Full where
  tallLayout = Tall 1 (3 / 100) (1 / 2)

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad $ docks def
    { modMask = mod4Mask  -- Windows key
    , terminal = "xterm"  -- TODO urxvt, cleanup config of urxvt!
    , keys = \conf -> mkKeymap conf $ myKeyBindings conf
    , workspaces = myWorkSpaces
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts myLayouts
    -- Set up statusbar (xmobar)
    , logHook = dynamicLogWithPP xmobarPP
        { ppOutput  = hPutStrLn xmproc
        , ppTitle   = xmobarColor "green" "" . shorten 100
        , ppCurrent = xmobarColor "#c0c0c0" "" . wrap "" ""
        , ppSep     = xmobarColor "#c0c0c0" "" " | "
        , ppUrgent  = xmobarColor "#ff69b4" ""
        , ppLayout = const ""  -- to disable the layout info on xmobar
        }
    }
