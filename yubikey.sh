
# Import public gpg 
# set trust to 5
# install scdaemon so gpg & ssh work
sudo apt-get install scdaemon -y


# Instructions from https://developers.yubico.com/yubico-pam/Authentication_Using_Challenge-Response.html

# Setting up PAM authentication
sudo apt-get install libpam-yubico 

## Install ykpersonalize
sudo apt-get install ykpersonalize

## Setup the YubiKey for challenge response on Slot 2
personalize -2 -ochal-resp -ochal-hmac -ohmac-lt64 -oserial-api-visible

## Set the current user to require this YubiKey for logon:
mkdir $HOME/.yubico
ykpamcfg -2 -v

# From security perspective, it is generally a good idea to move the challenge file in a system-wide path that is only read- and writable by root. To do this do as follow:

sudo mkdir /var/yubico
sudo chown root.root /var/yubico
sudo chmod 700 /var/yubico
ykpamcfg -2 -v
# Stored initial challenge and expected response in '$HOME/.yubico/challenge-123456'.
sudo mv ~/.yubico/challenge-123456 /var/yubico/alice-123456
sudo chown root.root /var/yubico/alice-123456
sudo chmod 600 /var/yubico/alice-123456
