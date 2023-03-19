import XMonad
import XMonad.Actions.CycleWS (toggleWS)

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.Dwindle
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed

import XMonad.StackSet (greedyView, shift, swapMaster)
import XMonad.Util.EZConfig (additionalKeysP)

myMask = mod4Mask

myTerminal = "urxvtc"

myBorderWidth = 2

surround l c = [c ++ x ++ c | x <- l]

myWorkspaces = surround ["α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι"] " "

myNormalBorderColor = "#0c0c0d"

myFocusedBorderColor = "#d8d8d8"

myFocusFollowsMouse = False

myTabConfig =
  def
    { inactiveBorderColor = "#0c0c0d",
      activeTextColor = "#d8d8d8",
      activeColor = "#181818",
      inactiveColor = "#0c0c0d",
      fontName = "xft:Cozette"
    }

myLayout = fullscreenNoBorders $ trimWordLeft $ gaps gapsWidth layouts
  where
    layouts = fibonacci ||| monocle ||| floating ||| tab ||| tiled

    -- Alias and functions
    trimWordLeft = renamed [CutWordsLeft 1] -- e.g. to remove 'Spacing' from layout name
    gaps i = spacingRaw False (Border i i i i) True (Border i i i i) True

    -- Custom layouts
    fibonacci = renamed [Replace "Fibonacci"] $ Dwindle R CW 1 1.2
    floating = renamed [Replace "Floating"] simplestFloat
    monocle = renamed [Replace "Monocle"] Full
    tiled = renamed [Replace "Tiled"] $ Tall nmaster delta ratio
    tab = renamed [Replace "Tabbed"] $ tabbed shrinkText myTabConfig

    -- Only remove borders on floating windows that cover the whole screen.
    fullscreenNoBorders = lessBorders OnlyScreenFloat

    -- Others values
    gapsWidth = 5 -- Gaps size in px
    nmaster = 1 -- Default number of windows in the master pane
    ratio = 1 / 2 -- Default proportion of screen occupied by master pane
    delta = 3 / 100 -- Percent of screen to increment by when resizing panes

myKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-p", spawn "drun"),
    ("M-q", kill),
    ("M-<Tab>", toggleWS),
    ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
    ("M-S-<Return>", windows swapMaster),
    -- Hack for workspace 10
    ("M-0", windows $ greedyView $ last myWorkspaces),
    ("M-S-0", windows $ shift $ last myWorkspaces),
    -- Media Keys
    ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioNext>", spawn "playerctl next"),
    ("<Print>", spawn "screenshot")
  ]

myXmobarPP =
  def
    { ppSep = magenta " ┃ ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = white . wrap " " "" . xmobarBorder "Bottom" anotherMagenta 2,
      ppHidden = lightgray . wrap " " "" . xmobarBorder "Bottom" anotherWhite 2,
      ppHiddenNoWindows = gray . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!")
    }
  where
    cyan = "#86c1b9"
    anotherWhite = "#d8d8d8"
    anotherMagenta = "#ba8baf"

    white = xmobarColor "#ffffff" ""
    magenta = xmobarColor "#ba8baf" ""
    lightgray = xmobarColor "#909090" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    gray = xmobarColor "#404040" ""

myConfig =
  def
    { modMask = myMask,
      focusFollowsMouse = myFocusFollowsMouse,
      layoutHook = myLayout,
      terminal = myTerminal,
      borderWidth = myBorderWidth,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      workspaces = myWorkspaces
    }
    `additionalKeysP` myKeys

main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
