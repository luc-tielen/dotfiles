Config { 
    font = "xft:Fira Code:pixelsize=14:antialias=true"
  , bgColor = "black"
  , fgColor = "white"
  , border = NoBorder
  , borderColor = "black"
  , position = Top
  , persistent = True
  , allDesktops = True
  , overrideRedirect = False
  , lowerOnStart = False
  , hideOnStart = False
  , commands = 
    [ Run Cpu [ "--Low", "3"
              , "--High","50"
              , "--normal", "white"
              , "--high", "white"
              ] 50
    , Run Memory [ "--template", "Mem: <usedratio>%" ] 100
    , Run Network "wlp5s0" [ "--Low", "0"
                           , "--High", "32"
                           , "--normal", "white"
                           , "--high", "white"
                           ] 50
    --, Run Com "~/.xmonad/volume.sh" [] "vol" 10
    , Run Volume "default" "Master" [] 10
    , Run Battery [ "--template", "Batt: <acstatus>"
                  , "--Low", "10"
                  , "--High", "80"
                  , "--low", "white"
                  , "--normal", "white"
                  , "--high", "white"
                  , "--"
                  , "-o", "<left>% (<timeleft>)"
                  , "-O", "<fc=#daa520>Charging</fc>"
                  , "-i", "<fc=#006000>Charged</fc>"
                  ] 100
    , Run Date "<fc=white>%a %x %H:%M</fc>" "date" 10
    , Run StdinReader
    ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %StdinReader% }{ %cpu% | %memory% | %wlp5s0% | %default:Master% | %battery% | %date% "
}
