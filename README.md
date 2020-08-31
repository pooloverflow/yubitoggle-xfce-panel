This is a simple script preventing accidentally triggering your yubikey. If you
are using mac, checkout this instead
[https://github.com/pallotron/yubiswitch](https://github.com/pallotron/yubiswitch).

### Prerequisites
1. Linux with xfce panel
2. Installed xinput

### YubiToggle Script

```bash
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
```

### Icons
Icons borrows from
[YubiGuard/icons](https://github.com/pykong/YubiGuard/tree/master/YubiGuard/icons)


### Steps to install
1. Save the above script as `yubitoggle` to a bin path (/usr/local/bin) and make
   it executable
2. Open `panel` application, go to items, add a `Generic Monitor` item 
3. Type `yubitoggle` in Command, uncheck Label and abjust how long should it run
   periodically (1 seconds)
4. Download the svg icons and place it `/usr/local/share/yubitoggle/icons/`
5. You're done! click the icon on the panel to toggle yubikey on & off

### Add Global Keyboard Shortcut (Optional)
1. Go to `keyboard -> Application Shortcuts`
2. Add a new item `yubitoggle "toggle"`
3. Set any shortcut as you want
