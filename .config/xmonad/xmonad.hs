{- ORMOLU_DISABLE -}
import XMonad
import XMonad.StackSet (focusWindow, greedyView, shift, swapMaster)

-- Actions
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS)
import XMonad.Actions.EasyMotion (EasyMotionConfig (..), fixedSize, selectWindow)
import XMonad.Actions.Promote (promote)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (manageDocks)
import XMonad.Hooks.ManageHelpers (composeOne, doCenterFloat, isDialog, transience, (-?>))
import XMonad.Hooks.Modal (floatMode, floatModeLabel, modal, setMode, logMode)
import XMonad.Hooks.PositionStoreHooks (positionStoreEventHook, positionStoreManageHook)
import XMonad.Hooks.StatusBar (defToggleStrutsKey, killStatusBar, spawnStatusBar, statusBarProp, withEasySB)
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.UrgencyHook (NoUrgencyHook (NoUrgencyHook), withUrgencyHook)

-- Layout
import XMonad.Layout.NoBorders (Ambiguity (OnlyScreenFloat), lessBorders)
import XMonad.Layout.PositionStoreFloat (positionStoreFloat)
import XMonad.Layout.Renamed (Rename (CutWordsLeft, Replace), renamed)
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Layout.Tabbed

-- Util
import XMonad.Util.ActionCycle (cycleAction)
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)
{- ORMOLU_ENABLE -}

myMask = mod4Mask

myTerminal = "urxvtc"

myBorderWidth = 2

surround l c = [c ++ x ++ c | x <- l]

myWorkspaces = surround ["α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι"] " "

myNormalBorderColor = "#0c0c0d"

myFocusedBorderColor = "#d8d8d8"

myFont = "xft:Cozette"

myFocusFollowsMouse = False

myTabConfig =
  def
    { inactiveBorderColor = "#0c0c0d",
      activeTextColor = "#d8d8d8",
      activeColor = "#181818",
      inactiveColor = "#0c0c0d",
      activeBorderWidth = 4,
      inactiveBorderWidth = 4,
      urgentBorderWidth = 4,
      fontName = myFont
    }

myLayout = fullscreenNoBorders $ trimWordLeft $ gaps gapsWidth layouts
  where
    layouts = tiled ||| monocle ||| tab ||| floating

    -- Alias and functions
    trimWordLeft = renamed [CutWordsLeft 1] -- e.g. to remove 'Spacing' from layout name
    gaps i = spacingRaw False (Border i i i i) True (Border i i i i) True

    -- Custom layouts
    floating = renamed [Replace "Floating"] positionStoreFloat
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

myEMConf =
  def
    { txtCol = "#b8b8b8",
      bgCol = "#0c0c0d",
      overlayF = fixedSize 30 30,
      borderCol = "#b8b8b8",
      borderPx = 4,
      emFont = myFont
    }

{- ORMOLU_DISABLE -}
myKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-p", spawn "drun"),
    ("M-q", kill),
    ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
    ("M-S-<Return>", promote),

    -- CycleWS
    ("M-<Tab>", toggleWS),
    ("M-,", prevWS),
    ("M-.", nextWS),

    -- Hack for workspace 10
    ("M-0", windows $ greedyView $ last myWorkspaces),
    ("M-S-0", windows $ shift $ last myWorkspaces),

    -- Layouts
    ("M1-t", sendMessage $ JumpToLayout "Tiled"),
    ("M1-b", sendMessage $ JumpToLayout "Tabbed"),
    ("M1-f", sendMessage $ JumpToLayout "Floating"),
    ("M1-m", sendMessage $ JumpToLayout "Monocle"),

    -- Easy Motion
    ("M-\\", selectWindow myEMConf >>= (`whenJust` windows . focusWindow)),

    -- Modal
    ("M-S-f", setMode floatModeLabel),

    -- Toggle Xmobar
    ("M-S-b", cycleAction "toggleXmobar" [killStatusBar "xmobar", spawnStatusBar "xmobar"]),

    -- Toggle Picom
    ("M-S-p", cycleAction "togglePicom" [spawn "notify-send 'Picom: OFF' && pkill picom", spawn "notify-send 'Picom: ON' && picom"]),

    -- Media Keys
    ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioNext>", spawn "playerctl next"),
    ("<Print>", spawn "screenshot")
  ]
{- ORMOLU_ENABLE -}

myXmobarPP =
  def
    { ppSep = magenta " ┃ ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = white . wrap " " "" . xmobarBorder "Bottom" anotherMagenta 2,
      ppTitle = shorten 40,
      ppHidden = lightgray . wrap " " "" . xmobarBorder "Bottom" anotherWhite 2,
      ppHiddenNoWindows = gray . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \(ws : l : x : xs) -> [ws, l] ++ xs ++ [x],
      ppExtras = [logMode]
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

myManageHook =
  positionStoreManageHook Nothing
    <> manageDocks
    <> composeOne
      [ transience,
        isDialog -?> doCenterFloat
      ]
    <> composeAll
      [ className =? "Xmessage" --> doCenterFloat
      ]

myHandleEventHook = positionStoreEventHook

myStartupHook = setDefaultCursor xC_left_ptr

myConfig =
  def
    { modMask = myMask,
      focusFollowsMouse = myFocusFollowsMouse,
      manageHook = myManageHook,
      handleEventHook = myHandleEventHook,
      startupHook = myStartupHook,
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
    . withUrgencyHook NoUrgencyHook
    . modal [floatMode 10]
    . withEasySB (statusBarProp "xmobar" $ clickablePP myXmobarPP) defToggleStrutsKey
    $ myConfig
