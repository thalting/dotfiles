{- ORMOLU_DISABLE -}
import XMonad
import XMonad.StackSet (focusWindow, greedyView, shift, shiftMaster, sink, focusDown, focusUp, view, swapDown, swapUp)

-- Actions
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS)
import XMonad.Actions.EasyMotion (EasyMotionConfig (..), fixedSize, selectWindow)
import XMonad.Actions.Commands (runCommand)
import XMonad.Actions.Promote (promote)
import XMonad.Actions.WindowBringer (gotoMenu, bringMenu)
import XMonad.Actions.SinkAll (sinkAll)
import XMonad.Actions.TiledWindowDragging (dragWindow)
import XMonad.Actions.CopyWindow (copy, kill1)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (manageDocks, checkDock)
import XMonad.Hooks.ManageHelpers (composeOne, doCenterFloat, isDialog, transience, (-?>), doLower)
import XMonad.Hooks.Modal (floatMode, floatModeLabel, modal, setMode, logMode)
import XMonad.Hooks.PositionStoreHooks (positionStoreEventHook, positionStoreManageHook)
import XMonad.Hooks.StatusBar (defToggleStrutsKey, killStatusBar, spawnStatusBar, statusBarProp, withEasySB)
import XMonad.Hooks.InsertPosition (insertPosition, Position (Below), Focus (Newer))
import XMonad.Hooks.StatusBar.PP

-- Layouts
import XMonad.Layout.Tabbed
import XMonad.Layout.TrackFloating (trackFloating, useTransientFor)
import XMonad.Layout.NoBorders (Ambiguity (OnlyScreenFloat), lessBorders)
import XMonad.Layout.PositionStoreFloat (positionStoreFloat)
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.Spacing (Border (Border), spacingRaw, incScreenSpacing, decScreenSpacing, incWindowSpacing, decWindowSpacing, setScreenWindowSpacing)
import XMonad.Layout.ResizableTile (ResizableTall(ResizableTall), MirrorResize (MirrorShrink, MirrorExpand))
import XMonad.Layout.DraggingVisualizer (draggingVisualizer)

-- Util
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.ActionCycle (cycleAction)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.ClickableWorkspaces (clickablePP)

-- Others
import qualified Data.Map as M
import System.Exit (exitSuccess)
{- ORMOLU_ENABLE -}

myMask = mod4Mask

myTerminal = "urxvtc"

myBorderWidth = 2

myWorkspaces = ["α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι"] `surround` " "
  where
    surround l c = [c ++ x ++ c | x <- l]

myNormalBorderColor = "#0c0c0d"

myFocusedBorderColor = "#d8d8d8"

myFont = "xft:Cozette"

myFocusFollowsMouse = False

myClickJustFocuses = False

myXmobarCMD = "cleanup() { trap : TERM; kill 0; }; trap cleanup EXIT; xmobar"

myTabConfig =
  def
    { inactiveBorderColor = "#101010",
      activeBorderColor = "#d8d8d8",
      activeTextColor = "#d8d8d8",
      activeColor = "#181818",
      activeBorderWidth = 2,
      inactiveBorderWidth = 2,
      urgentBorderWidth = 2,
      inactiveColor = "#0c0c0d",
      fontName = myFont
    }

myLayout = fullscreenNoBorders $ trackFloating $ useTransientFor layouts
  where
    layouts = tiled ||| monocle ||| floating ||| tab

    -- Alias and functions
    gaps i = spacingRaw False (Border i i i i) True (Border i i i i) True
    tabGaps i = spacingRaw False (Border i i i i) True (Border 0 0 0 0) True

    -- Custom layouts
    floating = renamed [Replace "Floating"] positionStoreFloat
    monocle = renamed [Replace "Monocle"] $ gaps gapsWidth Full
    tiled = renamed [Replace "Tiled"] $ gaps gapsWidth $ draggingVisualizer $ ResizableTall nmaster delta ratio []
    tab = renamed [Replace "Tabbed"] $ tabGaps (gapsWidth + 5) $ tabbed shrinkText myTabConfig

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

myCommands =
  return
    [ ("next-layout", sendMessage NextLayout),
      ("default-layout", asks (layoutHook . config) >>= setLayout),
      ("tiled", sendMessage $ JumpToLayout "Tiled"),
      ("tabbed", sendMessage $ JumpToLayout "Tabbed"),
      ("monocle", sendMessage $ JumpToLayout "Monocle"),
      ("floating", sendMessage $ JumpToLayout "Floating"),
      ("restart-wm", restart "xmonad" True),
      ("sink all", sinkAll),
      ("kill", kill),
      ("kill1", kill1),
      ("refresh", refresh)
    ]

{- ORMOLU_DISABLE -}
myAddKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-p", spawn "drun"),
    ("M-q", kill1),
    ("M-S-q", io exitSuccess),
    ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
    ("M-S-<Return>", promote),

    ("M-<Down>", sendMessage MirrorShrink),
    ("M-<Up>", sendMessage MirrorExpand),
    ("M-<Left>", sendMessage Shrink),
    ("M-<Right>", sendMessage Expand),

    -- Resizing the master/slave ratio
    ("M-a", sendMessage MirrorShrink),
    ("M-z", sendMessage MirrorExpand),

    -- Move focus up or down the window stack
    ("M-j", windows focusDown),
    ("M-k", windows focusUp),

    -- Resizing the master/slave ratio
    ("M-h", sendMessage Shrink),
    ("M-l", sendMessage Expand),

    -- Modifying the window order
    ("M-S-j", windows swapDown),
    ("M-S-k", windows swapUp),

    -- Commands
    ("M-x x", myCommands >>= runCommand),

    -- Window Finder
    ("M-x g", gotoMenu),
    ("M-x b", bringMenu),

    -- CycleWS
    ("M-<Tab>", toggleWS),
    ("M-,", prevWS),
    ("M-.", nextWS),

    -- Layouts
    ("M-t", sendMessage $ JumpToLayout "Tiled"),
    ("M-w", sendMessage $ JumpToLayout "Tabbed"),
    ("M-m", sendMessage $ JumpToLayout "Monocle"),
    ("M-f", sendMessage $ JumpToLayout "Floating"),

    -- Easy Motion
    ("M-\\", selectWindow myEMConf >>= (`whenJust` windows . focusWindow)),

    -- Modal
    ("M-S-f", setMode floatModeLabel),

    -- Toggle Xmobar
    ("M-S-b", spawn "dbus-send --session --dest=org.Xmobar.Control --type=method_call '/org/Xmobar/Control' org.Xmobar.Control.SendSignal \"string:Toggle 0\""),

    -- Toggle Picom
    ("M-C-S-p", cycleAction "togglePicom" [spawn "notify-send 'Picom: OFF' && pkill picom", spawn "notify-send 'Picom: ON' && picom"]),

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

myKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    [ ((modMask, xK_space), setLayout $ XMonad.layoutHook conf)
    ]
      ++ [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
             (f, m) <- [(greedyView, 0), (shift, shiftMask)]
         ]
      ++ [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
             (f, m) <- [(view, 0), (shift, shiftMask)]
         ]
      ++ [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
             (f, m) <- [(view, 0), (shift, shiftMask), (copy, shiftMask .|. controlMask)]
         ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList
    [ ((modMask .|. shiftMask, button1), dragWindow),
      ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows shiftMaster),
      ((modMask, button2), windows . (shiftMaster .) . focusWindow),
      ((modMask, button3), \w -> focus w >> Flex.mouseResizeWindow w),
      ((modMask, button4), const nextWS),
      ((modMask, button5), const prevWS)
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
    <> insertPosition Below Newer
    <> manageHook def

myHandleEventHook =
  positionStoreEventHook
    <> Hacks.windowedFullscreenFixEventHook

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn "setxkbmap -option compose:ralt"

myConfig =
  def
    { modMask = myMask,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      manageHook = myManageHook,
      handleEventHook = myHandleEventHook,
      startupHook = myStartupHook,
      layoutHook = myLayout,
      terminal = myTerminal,
      borderWidth = myBorderWidth,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      keys = myKeys,
      mouseBindings = myMouseBindings,
      workspaces = myWorkspaces
    }
    `additionalKeysP` myAddKeys

main =
  xmonad
    . Hacks.javaHack
    . ewmhFullscreen
    . ewmh
    . modal [floatMode 10]
    . withEasySB (statusBarProp myXmobarCMD (clickablePP myXmobarPP)) defToggleStrutsKey
    $ myConfig
