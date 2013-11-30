#!/bin/bash
echo "Installing build environment"
sudo apt-get -y install libperl-dev libgtk2.0-dev libusb-1.0-0-dev libnss3-dev
sudo apt-get -y install libtool
sudo apt-get -y install automake
sudo apt-get -y install libxv-dev

echo "Cloning libfprint"
git clone https://github.com/ars3niy/fprint_vfs5011.git -b release /tmp/fprint

echo "Building libfprint"
pushd /tmp/fprint
./autogen.sh
./configure --disable-log
make
echo "Installing libfprint"
sudo make install
popd

sudo add-apt-repository -y ppa:fingerprint/fingerprint-gui
sudo apt-get update
sudo apt-get -y install libbsapi policykit-1-fingerprint-gui fingerprint-gui

sudo chgrp -R plugdev /dev/bus/usb/
sudo usermod -a -G plugdev yura
