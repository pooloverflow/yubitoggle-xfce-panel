#!/bin/bash

yubi_xinput_name=$(xinput --list --name-only | grep -i YubiKey)

yubi_state=$(xinput --list-props "$yubi_xinput_name" | grep 'Device Enabled' | cut -d: -f 2 | xargs)

toggle_state(){
  if [[ $yubi_state == "1" ]]; then
    xinput --set-prop "$yubi_xinput_name" "Device Enabled" "0"
    yubi_state="0"
  elif [[ $yubi_state == "0" ]]; then
    xinput --set-prop "$yubi_xinput_name" "Device Enabled" "1"
    yubi_state="1"
  fi
}

change_icon(){
  if [[ $yubi_state == "1" ]]; then
    echo "<img>/usr/local/share/yubitoggle/icons/on_icon.svg</img>"
  else
    echo "<img>/usr/local/share/yubitoggle/icons/off_icon.svg</img>"
  fi
  echo "<click>yubitoggle "toggle"</click>"
  echo "<tool>click to toggle</tool>"
}

if [[ $1 == "toggle" ]]; then
  toggle_state
fi

change_icon
