Out-of-the-box SD card image for live streaming with Raspberry Pi. It's easy as pie.

<img src="https://github.com/iizukanao/picam-streamer/raw/master/images/screenshot.png" alt="Screenshot" style="max-width:100%;" width="500" height="408">

# How to use

1. Connect [Raspberry Pi Camera Module](https://www.raspberrypi.org/products/camera-module/) (and optionally a USB microphone) to a Raspberry Pi.
2. Download the SD card image from [http://s.kyu-mu.net/picam-streamer-latest/](http://s.kyu-mu.net/picam-streamer-latest/). This image is based on [Raspberry Pi OS (32-bit) Lite](https://www.raspberrypi.org/downloads/raspberry-pi-os/) version 2020-05-27.
3. Write the downloaded image to an SD card. Optionally, mount the image and create /boot/ssh empty file in order to automatically start SSH server on next boot.
4. Boot the Raspberry Pi. SSH server will automatically start. If you want to disable SSH server, please do so via `sudo raspi-config`.
5. Find out the Raspberry Pi's IP address. If you don't know how to find out the IP address, login to the Raspberry Pi with username `pi` and password `raspberry`, then run `ip a` command. To disable SSH server, run `raspi-config` and go to "Interfacing Options" &gt; "SSH" menu.
6. Open http://*RASPI_IP*/view/ with Flash Player-enabled browser. Replace *RASPI_IP* with the Raspberry Pi's IP address. Alternatively, you can view the stream with VLC media player via rtsp://*RASPI_IP*:80/live/picam URL.
7. If you use microphone, adjust microphone capture volume with `alsamixer` command. Press F6 to select your sound card, then press F4 to select "Capture" volume control. Use arrow keys to turn up or down the volume.

The expected latency of video is about a second. Also, please change your login password with `passwd` command.

## Disabling camera LED

Add `disable_camera_led=1` to /boot/config.txt and reboot the Pi.

## Components

The SD card image contains the following components.

- [picam](https://github.com/iizukanao/picam)
- [node-rtsp-rtmp-server](https://github.com/iizukanao/node-rtsp-rtmp-server)
- [Strobe Media Playback](http://sourceforge.net/adobe/smp/home/Strobe%20Media%20Playback/)
