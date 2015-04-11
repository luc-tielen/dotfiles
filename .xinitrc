#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Use Xresources:
xrdb ~/.Xresources &

# Belgian keyboard:
setxkbmap be &

# Activate numlock:
numlockx &

# Mute beep in terminal:
xset -b &

# Faster keyboard:
xset r rate 300 44 &

# Automatic mounting of hard disks, ... in /media: (unmount not automatic!)
(sleep 5 && devmon) &

# Pulseaudio (play multiple sounds at the same time):
start-pulseaudio-x11 &

# Location where Awesome WM should save configuration:
export XDG_CONFIG_HOME=~/.config/

# Finally start window manager:
exec awesome 
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
