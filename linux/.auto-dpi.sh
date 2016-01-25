#!/bin/bash

resolution=$(xrandr | head -n 1 | sed -e "s/.* current \([[:digit:]]\+ x [[:digit:]]\+\).*/\1/")
fonts_dir="$HOME/.config/fontconfig"
fonts_avail_dir="$HOME/.config/fontconfig.avail"

mkdir -p $fonts_dir

xrandr --auto
xrdb -merge ~/.Xresources

case $resolution in
  # Hopefully, Apple Thunderbult Display 27"
  "2560 x 1440")
    export UI_SCALE_FACTOR=1
    ln -fs $fonts_avail_dir/lodpi-fonts.conf $fonts_dir/fonts.conf
    xrandr --dpi 109
    xrdb -merge ~/.Xresources.lodpi
    ;;
  # Hopefully, Apple MacBook Pro 13"
  "2560 x 1600")
    ln -fs $fonts_avail_dir/hidpi-fonts.conf $fonts_dir/fonts.conf
    export UI_SCALE_FACTOR=2
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    xrandr --dpi 227
    xrdb -merge ~/.Xresources.hidpi
    ;;
  *)
    echo "Unknown resolution, only God can help us now..."
    ;;
esac

