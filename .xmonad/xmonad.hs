
module Main where

-- Imports:
import XMonad
import XMonad.Operations (kill)
import XMonad.Actions.CycleWS (prevWS, shiftToPrev, nextWS, shiftToNext)
import XMonad.Actions.Volume (lowerVolume, raiseVolume, toggleMute)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Hooks.DynamicLog (xmobarPP, xmobarColor)
import XMonad.Hooks.DynamicLog (ppOutput, ppTitle, ppCurrent, ppSep, ppUrgent, ppLayout)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, shorten, wrap)
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts, docks)
import qualified XMonad.StackSet as W
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
  , ("M-e", spawn "emacs")
  , ("<XF86HomePage>", spawn "chromium")
  -- Volume related keybindings:
  , ("<XF86AudioLowerVolume>", lowerVolume 1 >> return ())
  , ("<XF86AudioRaiseVolume>", raiseVolume 3 >> return ())
  , ("<XF86AudioMute>", toggleMute >> return ())
  -- Screen brightness keybindings:
  , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
  -- Keybindings for navigating across workspaces:
  -- TODO + switching workspaces, scrot, ...
  ]
  ++
  [("M-" ++ show num, windows $ W.greedyView wsId) 
    | (wsId, num) <- zip (workspaces conf) [1..9]
  ]
  ++
  [("M-S-" ++ show num, windows $ W.shift wsId) 
    | (wsId, num) <- zip (workspaces conf) [1..9]
  ]
  ++
  [ ("M-<Left>", prevWS)
  , ("M-S-<Left>", shiftToPrev)
  , ("M-<Right>", nextWS) 
  , ("M-S-<Right>", shiftToNext)
  ]

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
    , manageHook = manageDocks <+> manageHook def
    , layoutHook = avoidStruts $ smartBorders $ myLayouts
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
