# Clean-up 
systemctl stop shairport-sync
systemctl stop nqptp
rm /usr/local/bin/shairport-sync
rm /etc/systemd/system/shairport-sync.service
rm /etc/systemd/user/shairport-sync.service
rm /lib/systemd/user/shairport-sync.service
rm /etc/init.d/shairport-sync
rm /lib/systemd/system/nqptp.service
rm -rf ~/nqptp/
rm -rf ~/shairport-sync

# Build - NQPTP
cd ~
git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure --with-systemd-startup
make
make install
systemctl enable nqptp
systemctl start nqptp

# Build - Shairport Sync
cd ~
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
#  git checkout development
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa \
--with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2
make
make install
systemctl enable shairport-sync
systemctl start shairport-sync