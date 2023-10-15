sudo apt-get update
sudo apt-get upgrade

sudo dpkg -i cisco-webex-vdi_43.4.0.25959_amd64.deb
sudo apt install -f ./icaclient_23.9.0.24_amd64.deb
   

## Download the icaclient

https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html


### install with

```
 sudo apt install -f ./icaclient_<version>._amd64.deb
```

install the usb package with

```
 sudo apt install -f ctxusb_<version>._amd64.deb
```


## To get teams working:

Install:
	- Gstreamer
	- libc++-9.0 or later
	- libgdk 3.22 or later


### Gstreamer

```
apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
```

### libc++1-12
```
sudo apt-get -y install libc++1-12
```
