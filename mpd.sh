# Installing and setting up mpd

## Step 1: install mpd
sudo apt-get install mpd

## Step 2: By default Ubuntu installs mpd as a system service, We don't want this, so let's remove it from startup.

### if mpd is running stop it first

/etc/init.d/mpd stop
sudo update-rc.d mpd disable


