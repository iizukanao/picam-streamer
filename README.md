# How to use

1. Download the SD card image from http://s.kyu-mu.net/picam-streamer-latest/ which is based on Raspbian jessie.
2. Write it to an SD card larger than 4.5GB.
3. Boot the Raspberry Pi and login with pi/raspberry as username and password.
4. Run `sudo raspi-config` and expand the filesystem.
5. Also change the password.
6. Find out the IP address of your Raspberry Pi with `ifconfig` command.
7. Open http:/RASPI_IP/view/ with Flash Player enabled browser. Replace RASPI_IP with the IP address of your Raspberry Pi.

## Disabling camera LED

Add `disable_camera_led=1` to /boot/config.txt and reboot the Pi.
