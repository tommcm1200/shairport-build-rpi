

# Get Tools and Libraries
sudo apt -y update
sudo apt -y upgrade # this is optional but recommended
sudo apt -y install --no-install-recommends build-essential git xmltoman autoconf automake libtool \
libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev \
libplist-dev libsodium-dev libavutil-dev libavcodec-dev libavformat-dev uuid-dev libgcrypt-dev xxd
sudo iwconfig wlan0 power off


# Configure default sound device 
# https://www.alsa-project.org/wiki/Setting_the_default_device
# Find your desired card with:

#    cat /proc/asound/cards

# and then create /etc/asound.conf with following:

#    defaults.pcm.card 1
#    defaults.ctl.card 1

# Replace "1" with number of your card determined above.


# Install Docker
# sudo curl -sSL https://get.docker.com | sh
# sudo usermod -aG docker pi
# docker run --net host --device /dev/snd mikebrady/shairport-sync -o pipe -- /output
# docker run --net host --device /dev/snd mikebrady/shairport-sync:unstable-development shairport-sync
# docker run -d --restart unless-stopped --net host --device /dev/snd mikebrady/shairport-sync -o pipe -- /output
# sudo docker run --net host --device /dev/snd mikebrady/shairport-sync shairport-sync
# sudo docker run --net host --device /dev/snd mikebrady/shairport-sync shairport-sync:unstable-development
# sudo docker run -v /etc/shairport-sync.conf:/etc/shairport-sync.conf --net host --device /dev/snd mikebrady/shairport-sync shairport-sync
# docker run -d --restart unless-stopped --net host --device /dev/snd mikebrady/shairport-sync:unstable-development shairport-sync
# docker run -d --restart unless-stopped --net host --device /dev/snd mikebrady/shairport-sync shairport-sync


# Setup daily 4am reboot
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 4 * * * /sbin/shutdown -r now" >> mycron
#install new cron file
crontab mycron
rm mycron

# Build - SPS ALSA EXPLORE
cd ~
git clone https://github.com/mikebrady/sps-alsa-explore.git
cd sps-alsa-explore
sudo autoreconf -fi
sudo ./configure
sudo make


#Instal and config pirate audio line-out
git clone https://github.com/pimoroni/pirate-audio
cd pirate-audio/mopidy
sudo ./install.sh

#Setup PhatDAC (https://learn.pimoroni.com/article/raspberry-pi-phat-dac-install)
# curl https://get.pimoroni.com/phatdac | bash

#Reboot
sudo reboot