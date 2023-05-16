{- ORMOLU_DISABLE -}
import XMonad
import XMonad.StackSet (focusWindow, greedyView, shift, swapMaster, shiftMaster, sink)

-- Actions
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS)
import XMonad.Actions.EasyMotion (EasyMotionConfig (..), fixedSize, selectWindow)
import XMonad.Actions.Promote (promote)
import XMonad.Actions.SinkAll
import XMonad.Actions.TiledWindowDragging
import XMonad.Layout.DraggingVisualizer

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (manageDocks, checkDock)
import XMonad.Hooks.ManageHelpers (composeOne, doCenterFloat, isDialog, transience, (-?>), doLower)
import XMonad.Hooks.Modal (floatMode, floatModeLabel, modal, setMode, logMode)
import XMonad.Hooks.PositionStoreHooks (positionStoreEventHook, positionStoreManageHook)
import XMonad.Hooks.StatusBar (defToggleStrutsKey, killStatusBar, spawnStatusBar, statusBarProp, withEasySB)
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.UrgencyHook (NoUrgencyHook (NoUrgencyHook), withUrgencyHook)

-- Layout
import XMonad.Layout.NoBorders (Ambiguity (OnlyScreenFloat), lessBorders)
import XMonad.Layout.PositionStoreFloat (positionStoreFloat)
import XMonad.Layout.Renamed (Rename (CutWordsLeft, Replace), renamed)
import XMonad.Layout.Spacing (Border (Border), spacingRaw, incScreenSpacing, decScreenSpacing, incWindowSpacing, decWindowSpacing, setScreenWindowSpacing)

-- Util
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.ActionCycle (cycleAction)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)

-- Others
import qualified Data.Map as M
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

myXmobarCMD = "cleanup() { trap : TERM; kill 0; }; trap cleanup EXIT; xmobar"

myLayout = fullscreenNoBorders $ trimWordLeft $ gaps gapsWidth layouts
  where
    layouts = tiled ||| monocle ||| floating

    -- Alias and functions
    trimWordLeft = renamed [CutWordsLeft 1] -- e.g. to remove 'Spacing' from layout name
    gaps i = spacingRaw False (Border i i i i) True (Border i i i i) True

    -- Custom layouts
    floating = renamed [Replace "Floating"] positionStoreFloat
    monocle = renamed [Replace "Monocle"] Full
    tiled = renamed [Replace "Tiled"] $ draggingVisualizer $ Tall nmaster delta ratio

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
    ("M-t", sendMessage $ JumpToLayout "Tiled"),
    ("M-f", sendMessage $ JumpToLayout "Floating"),
    ("M-m", sendMessage $ JumpToLayout "Monocle"),

    -- Easy Motion
    ("M-\\", selectWindow myEMConf >>= (`whenJust` windows . focusWindow)),

    -- Modal
    ("M-S-f", setMode floatModeLabel),

    -- Toggle Xmobar
    ("M-S-b", cycleAction "toggleXmobar" [killStatusBar myXmobarCMD, spawnStatusBar myXmobarCMD]),

    -- Toggle Picom
    ("M-S-C-p", cycleAction "togglePicom" [spawn "notify-send 'Picom: OFF' && pkill picom", spawn "notify-send 'Picom: ON' && picom"]),

    -- Push all window back into tiling
    ("M-S-C-<Space>", sinkAll),
    -- Push window back into tiling
    ("M-S-<Space>", withFocused $ windows . sink),

    -- Spacing
    ("M-C-S-r", setScreenWindowSpacing 5),
    ("M-C-S-k", incScreenSpacing 5),
    ("M-C-S-j", decScreenSpacing 5),
    ("M-C-S-l", incWindowSpacing 5),
    ("M-C-S-h", decWindowSpacing 5),

    -- Media Keys
    ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && pkill -RTMIN+10 blocks"),
    ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pkill -RTMIN+10 blocks"),
    ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pkill -RTMIN+10 blocks"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioNext>", spawn "playerctl next"),
    ("<Print>", spawn "screenshot")
  ]
{- ORMOLU_ENABLE -}

myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList
    [ ((modMask .|. shiftMask, button1), dragWindow),
      ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows shiftMaster),
      ((modMask, button2), windows . (shiftMaster .) . focusWindow),
      ((modMask, button3), \w -> focus w >> Flex.mouseResizeWindow w)
    ]

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
      [ className =? "Xmessage" --> doCenterFloat,
        title =? "Picture-in-Picture" --> doFloat,
        checkDock --> doLower
      ]

myHandleEventHook =
  handleEventHook def
    <> positionStoreEventHook
    <> Hacks.windowedFullscreenFixEventHook

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn "setxkbmap -option compose:ralt"

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
      mouseBindings = myMouseBindings,
      workspaces = myWorkspaces
    }
    `additionalKeysP` myKeys

main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withUrgencyHook NoUrgencyHook
    . modal [floatMode 10]
    . withEasySB (statusBarProp myXmobarCMD (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
