Config { 
    font = "xft:Fira Code:pixelsize=12:antialias=true"
  , bgColor = "#002b36"
  , fgColor = "#657b83"
  , border = NoBorder
  , borderColor = "black"
  , position = Top
  , persistent = True
  , allDesktops = True
  , overrideRedirect = False
  , lowerOnStart = False
  , hideOnStart = False
  , commands = 
    [ Run Weather "UUEE" ["-t"," <tempC>C","-L","64","-H","77","--normal","#657b83","--high","#657b83","--low","#657b83"] 36000
    , Run Network "enp4s0" ["-L","0","-H","32","--normal","#657b83","--high","#657b83"] 10
    , Run Cpu ["-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
    , Run Memory ["-t","Mem: <usedratio>%"] 10
    , Run Com "~/.xmonad/volume.sh" [] "vol" 1
    , Run Date "<fc=#93a1a1>%a %b %_d %Y %H:%M</fc>" "date" 10
    , Run StdinReader
    ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %StdinReader% }{ %cpu% | %memory% | %enp4s0% | %vol% | Hasselt:%UUEE% | %date% "
}
