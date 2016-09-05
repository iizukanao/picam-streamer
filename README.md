Out-of-the-box SD card image for live streaming with Raspberry Pi. It's easy as pie.

<img src="https://github.com/iizukanao/picam-streamer/raw/master/images/screenshot.png" alt="Screenshot" style="max-width:100%;" width="500" height="408">

# How to use

1. Connect [Raspberry Pi Camera Module](https://www.raspberrypi.org/products/camera-module/) (and optionally a USB microphone) to Raspberry Pi.
2. Download the SD card image from [http://s.kyu-mu.net/picam-streamer-latest/](http://s.kyu-mu.net/picam-streamer-latest/). This image is based on [Raspbian Jessie Lite](https://www.raspberrypi.org/downloads/raspbian/).
3. Write the downloaded image to your SD card.
4. Boot the Raspberry Pi and login with `pi` and `raspberry` as the username and password.
5. Change your password with `passwd` command.
6. Find out your Raspberry Pi's IP address with `ifconfig` command.
7. Open http://RASPI_IP/view/ with Flash Player enabled browser. Replace RASPI_IP with your Raspberry Pi's IP address. The expected latency of video is about a second.

## Disabling camera LED

Add `disable_camera_led=1` to /boot/config.txt and reboot the Pi.

## Components

The SD card image contains the following components.

- [picam](https://github.com/iizukanao/picam)
- [node-rtsp-rtmp-server](https://github.com/iizukanao/node-rtsp-rtmp-server)
- [Strobe Media Playback](http://sourceforge.net/adobe/smp/home/Strobe%20Media%20Playback/)
