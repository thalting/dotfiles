import Xmobar

volTemplate = volMute . volUp . volDown $ ":volume:"
  where
    volUpCmd = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && client --name vol"
    volDownCmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && client --name vol"
    volMuteCmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && client --name vol"

    volUp inner = "<action=`" ++ volUpCmd ++ "` button=4>" ++ inner ++ "</action>"
    volDown inner = "<action=`" ++ volDownCmd ++ "` button=5>" ++ inner ++ "</action>"
    volMute inner = "<action=`" ++ volMuteCmd ++ "` button=2>" ++ inner ++ "</action>"

config =
  defaultConfig
    { overrideRedirect = False,
      font = "Cozette 8",
      bgColor = "#0c0c0d",
      fgColor = "#b8b8b8",
      position = TopHM 25 10 10 10 0,
      textOffset = 1,
      commands =
        [ Run XMonadLog,
          Run $ CommandReader "echo && playerctl --follow metadata --format '♫ {{default(trunc(artist, 20), \"N/A\")}} - {{default(trunc(title, 30), \"N/A\")}}'" "mpris",
          Run $ CommandReader "sleep 1s && server --name vol" "volume",
          Run $ Date "%A, %d %B %Y, %I:%M %p" "date" 30,
          Run StdinReader
        ],
      sepChar = ":",
      template = ":XMonadLog: }{ <action=`playerctl play-pause` button=2>:mpris:</action> ┃ " ++ volTemplate ++ " ┃ :date: ┃ "
    }

main = xmobar config
