# load resources
xrdb -load ~/.Xresources
xrandr --rate 144.0 &
picom --vsync &
feh --bg-scale ~/Pictures/leaf.jpg &
polybar example &

# launch window manager
2bwm&
exec termite

