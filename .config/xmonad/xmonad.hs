import XMonad

import XMonad.Hooks.StatusBar
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CycleWS

import System.Exit

myMask               = mod4Mask
myTerminal           = "urxvtc"
myBorderWidth        = 4
myWorkspaces         = [ "α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι" ]
myNormalBorderColor  = "#0c0c0d"
myFocusedBorderColor = "#d8d8d8"

myLayout = lessBorders OnlyFloat $ spacing 10 $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myKeys =
    [ ("M-<Return>", spawn myTerminal)
    , ("M-p", spawn "drun")
    , ("M-q", kill)
    , ("M-<Tab>", toggleWS)
    , ("M-r", spawn "xmonad --recompile && xmonad --restart")

    -- Hack for workspace 10
    , ("M-0", windows $ W.greedyView $ last myWorkspaces)
    , ("M-S-0", windows $ W.shift $ last myWorkspaces)

    , ("M-S-<Return>", windows W.swapMaster)

    , ("<F11>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
    , ("<F10>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
    , ("<F9>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

    , ("<F6>", spawn "playerctl previous")
    , ("<F7>", spawn "playerctl play-pause")
    , ("<F8>", spawn "playerctl next")
    ]

myConfig = def
    { modMask            = myMask
    , layoutHook         = myLayout
    , terminal           = myTerminal
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    }
    `additionalKeysP` myKeys

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure def)) defToggleStrutsKey
     $ myConfig
