{- ORMOLU_DISABLE -}
import XMonad
import XMonad.StackSet (focusWindow, greedyView, shift, shiftMaster, sink, focusDown, focusUp, view, swapDown, swapUp, layout, workspace, current)

-- Actions
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS)
import XMonad.Actions.EasyMotion (EasyMotionConfig (..), fixedSize, selectWindow)
import XMonad.Actions.Commands (runCommand)
import XMonad.Actions.Promote (promote)
import XMonad.Actions.WindowBringer (gotoMenu, bringMenu, copyMenu)
import XMonad.Actions.WithAll (sinkAll)
import XMonad.Actions.TiledWindowDragging (dragWindow)
import XMonad.Actions.CopyWindow (copy, kill1)
import XMonad.Actions.ToggleFullFloat (toggleFullFloat, toggleFullFloatEwmhFullscreen)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (manageDocks, checkDock)
import XMonad.Hooks.Modal (floatMode, floatModeLabel, modal, setMode, logMode)
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doFullFloat, doLower, transience')
import XMonad.Hooks.StatusBar (defToggleStrutsKey, statusBarProp, withEasySB)
import XMonad.Hooks.InsertPosition (insertPosition, Focus (Newer), Position (Below))
import XMonad.Hooks.RefocusLast (refocusLastLayoutHook, refocusLastWhen, isFloat)
import XMonad.Hooks.StatusBar.PP (PP (..), xmobarStrip, xmobarColor, xmobarBorder, wrap, shorten)

-- Layouts
import XMonad.Layout.Tabbed (Theme (..), shrinkText, tabbed)
import XMonad.Layout.ResizableThreeColumns (ResizableThreeCol (ResizableThreeCol))
import XMonad.Layout.NoBorders (Ambiguity (OnlyScreenFloat), lessBorders)
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.Spacing (Border (Border), spacingRaw, incScreenSpacing, decScreenSpacing, incWindowSpacing, decWindowSpacing, setScreenWindowSpacing)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall), MirrorResize (MirrorShrink, MirrorExpand))
import XMonad.Layout.DraggingVisualizer (draggingVisualizer)
import XMonad.Layout.FocusTracking (focusTracking)

-- Util
import XMonad.Util.ActionCycle (cycleAction)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.SessionStart (isSessionStart, setSessionStarted, doOnce)

-- Others
import qualified Data.Map as M
import Data.Maybe (mapMaybe)
import System.Exit (exitSuccess)
import System.Directory.Extra (listFilesRecursive)
import System.Environment (getEnv)
import System.Random (randomRIO)
{- ORMOLU_ENABLE -}

myMask = mod4Mask

myTerminal = "alacritty msg create-window || alacritty"

myBorderWidth = 2

myWorkspaces = ["α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι"] `surround` " "
  where
    surround l c = [c ++ x ++ c | x <- l]

myNormalBorderColor = "#0c0c0d"

myFocusedBorderColor = "#d8d8d8"

myFont = "xft:Cozette"

myFocusFollowsMouse = False

myClickJustFocuses = False

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

myLayout = fullscreenNoBorders $ refocusLastLayoutHook $ focusTracking layouts
  where
    layouts = tiled ||| columns ||| monocle ||| tab

    -- Alias and functions
    gaps i = spacingRaw False (Border i i i i) True (Border i i i i) True
    tabGaps i = spacingRaw False (Border i i i i) True (Border 0 0 0 0) True

    -- Custom layouts
    monocle = renamed [Replace "Monocle"] $ gaps gapsWidth Full
    columns = renamed [Replace "Columns"] $ gaps gapsWidth $ draggingVisualizer $ ResizableThreeCol nmaster delta ratio []
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
      borderPx = 2,
      emFont = myFont
    }

myCommands =
  pure
    [ ("next-layout", sendMessage NextLayout),
      ("default-layout", asks (layoutHook . config) >>= setLayout),
      ("tiled", sendMessage $ JumpToLayout "Tiled"),
      ("tabbed", sendMessage $ JumpToLayout "Tabbed"),
      ("monocle", sendMessage $ JumpToLayout "Monocle"),
      ("floating", sendMessage $ JumpToLayout "Floating"),
      ("restart-wm", restart "xmonad" True),
      ("sink-all", sinkAll),
      ("kill", kill),
      ("kill1", kill1),
      ("refresh", refresh),
      ("setup-inputs", setupInputs)
    ]

data Description = Desc String | Nil

data Keys a = Key (String, a, Description) | Title String

{- ORMOLU_DISABLE -}
myAddKeys' =
  [ Title "Misc",
    Key ("M-<Return>", spawn myTerminal, Desc "Spawn a new terminal"),
    Key ("M-p", spawn "rofi -show run", Desc "Open the application launcher"),
    Key ("M-q", kill1, Desc "Close the focused window"),
    Key ("M-S-q", io exitSuccess, Desc "Quit Xmonad"),
    Key ("M-S-r", spawn "xmonad --recompile && xmonad --restart", Desc "Recompile and restart Xmonad"),
    Key ("M-S-<Return>", promote, Desc "Promote the focused window to the master window"),

    Title "Resizing the master/slave ratio",
    Key ("M-<Down>", sendMessage MirrorShrink, Desc "Shrink the focused window vertically"),
    Key ("M-<Up>", sendMessage MirrorExpand, Desc "Expand the focused window vertically"),
    Key ("M-<Left>", sendMessage Shrink, Desc "Shrink the focused window horizontally"),
    Key ("M-<Right>", sendMessage Expand, Desc "Expand the focused window horizontally"),

    Title "Move focus up or down the window stack",
    Key ("M-j", windows focusDown, Desc "Focus the next window in the stack"),
    Key ("M-k", windows focusUp, Desc "Focus the previous window in the stack"),

    Title "Resizing the master/slave ratio",
    Key ("M-h", sendMessage Shrink, Desc "Shrink the focused window"),
    Key ("M-l", sendMessage Expand, Desc "Expand the focused window"),

    Title "Modifying the window order",
    Key ("M-S-j", windows swapDown, Desc "Swap the focused window with the next window in the stack"),
    Key ("M-S-k", windows swapUp, Desc "Swap the focused window with the previous window in the stack"),

    Title "Commands",
    Key ("M-x x", myCommands >>= runCommand, Desc "Run a custom command"),

    Title "Window Finder",
    Key ("M-x g", gotoMenu, Desc "Go to a window by name"),
    Key ("M-x b", bringMenu, Desc "Bring a window to the current workspace by name"),
    Key ("M-x y", copyMenu, Desc "Copy a window to the current workspace by name"),

    Title "CycleWS",
    Key ("M-<Tab>", toggleWS, Desc "Toggle between visible workspaces"),
    Key ("M-,", prevWS, Desc "Switch to the previous workspace"),
    Key ("M-.", nextWS, Desc "Switch to the next workspace"),

    Title "Layouts",
    Key ("M-t", sendMessage $ JumpToLayout "Tiled", Desc "Switch to the Tiled layout"),
    Key ("M-w", sendMessage $ JumpToLayout "Tabbed", Desc "Switch to the Tabbed layout"),
    Key ("M-m", sendMessage $ JumpToLayout "Monocle", Desc "Switch to the Monocle layout"),
    Key ("M-f", sendMessage $ JumpToLayout "Floating", Desc "Switch to the Floating layout"),

    Key ("M-S-C-<Space>", asks (layoutHook . config) >>= setLayout, Desc "Set the current layout to the selected one"),

    Title "Easy Motion",
    Key ("M-\\", selectWindow myEMConf >>= (`whenJust` windows . focusWindow), Desc "Select a window using Easy Motion"),

    Title "Modal",
    Key ("M1-S-f", setMode floatModeLabel, Desc "Enter float mode"),

    Title "Toggle Xmobar",
    Key ("M-S-b", spawn "dbus-send --session --dest=org.Xmobar.Control --type=method_call '/org/Xmobar/Control' org.Xmobar.Control.SendSignal \"string:Toggle 0\"", Desc "Toggle Xmobar visibility"),

    Title "Toggle Picom",
    Key ("M-C-S-p", cycleAction "togglePicom" [spawn "notify-send 'Picom: OFF' && pkill picom", spawn "notify-send 'Picom: ON' && picom"], Desc "Toggle Picom compositing"),

    Title "Increase or decrease number of windows in the master area",
    Key ("M-i", sendMessage $ IncMasterN 1, Desc "Increase the number of windows in the master area"),
    Key ("M-d", sendMessage $ IncMasterN $ -1, Desc "Decrease the number of windows in the master area"),

    Title "Push all window back into tiling",
    Key ("M-S-<Space>", sinkAll, Desc "Push all windows back into tiling"),
    Title "Push window back into tiling",
    Key ("M-<Space>", withFocused $ windows . sink, Desc "Push the focused window back into tiling"),

    Key ("M-S-f", withFocused toggleFullFloat, Desc "Toggle full float for the focused window"),

    Title "Spacing",
    Key ("M-C-S-r", setScreenWindowSpacing 5, Desc "Set the window spacing for the current screen"),
    Key ("M-C-S-k", incScreenSpacing 5, Desc "Increase the window spacing for the current screen"),
    Key ("M-C-S-j", decScreenSpacing 5, Desc "Decrease the window spacing for the current screen"),
    Key ("M-C-S-l", incWindowSpacing 5, Desc "Increase the window spacing"),
    Key ("M-C-S-h", decWindowSpacing 5, Desc "Decrease the window spacing"),

    Title "Media Keys",
    Key ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && client --name vol", Desc "Increase the volume"),
    Key ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && client --name vol", Desc "Decrease the volume"),
    Key ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && client --name vol", Desc "Toggle mute"),
    Key ("<XF86AudioPrev>", spawn "playerctl previous", Desc "Play the previous track"),
    Key ("<XF86AudioPlay>", spawn "playerctl play-pause", Desc "Play/Pause media"),
    Key ("<XF86AudioNext>", spawn "playerctl next", Desc "Play the next track"),
    Key ("<Print>", spawn "screenshot", Desc "Take a screenshot"),

    Key ("M-x h", xmessage help, Desc "Display help")
  ]
{- ORMOLU_ENABLE -}

myAddKeys = mapMaybe getKeyAndFn myAddKeys'
  where
    getKeyAndFn (Key (x, y, _)) = Just (x, y)
    getKeyAndFn (Title _) = Nothing

help = unlines $ map addPadding listRaw
  where
    getKeyAndDesc (Key (x, _, Desc y)) = [x, y]
    getKeyAndDesc (Key (x, _, Nil)) = [x]
    getKeyAndDesc (Title x) = ["\n" ++ x]

    keyLength [x] = length x
    keyLength [x, _] = length x
    largestKeySize = maximum $ map keyLength listRaw

    addPadding [x] = x
    addPadding [x, y] = x ++ concat (replicate (1 + largestKeySize - length x) " ") ++ y

    listRaw = map getKeyAndDesc myAddKeys'

myKeys (XConfig {modMask = modMask, workspaces = workspaces, layoutHook = layoutHook}) =
  M.fromList $
    [ ((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip workspaces workspaceKeys,
        (f, m) <- [(greedyView, 0), (shift, shiftMask)]
    ]
      ++ [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
             (f, m) <- [(view, 0), (shift, shiftMask)]
         ]
      ++ [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip workspaces workspaceKeys,
             (f, m) <- [(view, 0), (shift, shiftMask), (copy, shiftMask .|. controlMask)]
         ]
  where
    workspaceKeys = [xK_1 .. xK_9] ++ [xK_0]

myMouseBindings (XConfig {modMask = modMask}) =
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
  manageDocks
    <> composeAll
      [ isFullscreen --> doFullFloat,
        isDialog --> doFloat,
        fmap not willFloat --> insertPosition Below Newer,
        checkDock --> doLower,
        transience'
      ]
    <> manageHook def

myHandleEventHook =
  refocusLastWhen (isLayout "Tabbed" <||> isFloat) -- or (pure True) to always refocus last
  where
    isLayout layoutName = ls >>= \x -> pure $ x == layoutName
      where
        ls = liftX . withWindowSet $ pure . description . layout . workspace . current

setupInputs = do
  spawn "xset r rate 300 60"
  spawn "xinput set-prop 'pointer:Compx VXE NordicMouse 1K Dongle' 'libinput Accel Speed' -0.75"
  spawn "xinput set-prop 'Primax Kensington Eagle Trackball' 'libinput Natural Scrolling Enabled' 1"
  spawn "xinput set-prop 'Primax Kensington Eagle Trackball' 'libinput Left Handed Enabled' 1"

choice xs = randomRIO (0, length xs - 1) >>= \index -> pure (xs !! index)

randomWallpaper = do
  home <- getEnv "HOME"
  wallpapers <- listFilesRecursive $ home ++ "/pictures/wallpapers/"
  wallpaper <- choice wallpapers
  spawn $ unwords ["xwallpaper", "--zoom", "'" ++ wallpaper ++ "'"]

myStartupHook = do
  doOnce $ io randomWallpaper
  setDefaultCursor xC_left_ptr
  setupInputs
  setSessionStarted

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
    . toggleFullFloatEwmhFullscreen
    . ewmhFullscreen
    . ewmh
    . modal [floatMode 10]
    . withEasySB (statusBarProp "xmobar" $ clickablePP myXmobarPP) defToggleStrutsKey
    $ myConfig
