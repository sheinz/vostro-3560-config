#!/bin/bash

echo "Setting up Dell fun control"
sudo apt-get -y install i8kutils
sudo cp i8kmon /etc/default/i8kmon
sudo cp i8kmon.conf /etc/i8kmon.conf

echo "Setting up Dell backlight"
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="acpi_backlight=vendor"/g' /etc/default/grub
sudo update-grub

echo "Installing Chrome"
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo apt-get update
sudo apt-get -y install google-chrome-stable

echo "Setting up vgaswitcheroo"
sudo sed -i -e '$i \echo IGD > /sys/kernel/debug/vgaswitcheroo/switch\n' /etc/rc.local
sudo sed -i -e '$i \echo OFF > /sys/kernel/debug/vgaswitcheroo/switch\n' /etc/rc.local

echo "Installing VIM"
sudo apt-get -y install vim
sudo apt-get -y install vim-gnome

echo "Installing GIT"
sudo apt-get -y install git-core

echo "Removing Firefox"
sudo apt-get -y remove firefox

echo "Installing meld"
sudo apt-get -y install meld

echo "Setting up VIM"
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
wget https://raw.github.com/sheinz/my-vim-config/master/.vimrc -O ~/.vimrc

echo "Setting up GIT"
cp gitconfig ~/.gitconfig
sudo cp git-meld /usr/bin/git-meld
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
echo "source ~/.git-completion.bash" >> ~/.bashrc
echo "source ~/.git-prompt.sh" >> ~/.bashrc
TEMP_PS1='\W$(__git_ps1 "(%s)") > '
echo "PS1='${TEMP_PS1}'" >> ~/.bashrc
wget https://raw.github.com/wmanley/git-meld/master/git-meld.pl -O /tmp/git-meld.pl
chmod +x /tmp/git-meld.pl
sudo cp /tmp/git-meld.pl /usr/bin/git-meld.pl


echo "Installing encfs"
sudo apt-get -y install encfs
sudo add-apt-repository -y ppa:gencfsm
sudo apt-get update
sudo apt-get -y install gnome-encfs-managere

echo "Adding optimization to /etc/fstab. Please uncomment to enable"
sudo sh -c 'echo "#UUID= /               ext4    discard,noatime,nodiratime,errors=remount-ro 0       1" >> /etc/fstab'
sudo sh -c 'echo "#tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0" >> /etc/fstab'
sudo sh -c 'echo "#tmpfs /var/tmp tmpfs defaults,noatime,mode=1777 0 0" >> /etc/fstab'
sudo sh -c 'echo "#tmpfs /var/log tmpfs defaults,noatime,mode=0755 0 0" >> /etc/fstab'
sudo sh -c 'echo "#tmpfs /var/log/apt tmpfs defaults,noatime 0 0" >> /etc/fstab'
sudo sh -c 'echo "# none /var/cache unionfs dirs=/tmp:/var/cache=ro 0 0" >> /etc/fstab'

echo "Tuning hdparm.conf"
sudo sh -c 'cat hdparm.conf >> /etc/hdparm.conf'


echo "Setting up udev rules"
sudo cp 31-arduino.rules /etc/udev/rules.d/31-arduino.rules
sudo cp 41-atmega.rules /etc/udev/rules.d/41-atmega.rules 
sudo cp 51-usboscill.rules /etc/udev/rules.d/51-usboscill.rules
sudo service udev restart


echo "Installing AVR enviroment"
sudo apt-get -y install gcc-avr
sudo apt-get -y install avr-libc
sudo apt-get -y install avrdude
sudo apt-get -y install cmake

echo "Setting wallpaper"
cp wallpaper.jpg ~/Pictures/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/wallpaper.jpg

echo "Setting up sudo without password"
EXEC_LINE="echo \"$USER ALL=(ALL) NOPASSWD: ALL\">> /etc/sudoers"
sudo sh -c "$EXEC_LINE"

echo "Installing skype"
sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu/ precise partner' >> /etc/apt/sources.list.d/canonical_partner.list"
sudo apt-get update
sudo apt-get -y install skype

echo "Installing vlc player"
sudo apt-get -y install vlc

echo "Installing VirtualBox"
sudo apt-get -y install virtualbox
sudo usermod -aG vboxusers $USER

echo "Installing EagleCAD"
sudo apt-get -y install eagle

echo "Installing setuptools for python"
sudo apt-get -y install python-setuptools
sudo apt-get -y install python-virtualenv
sudo apt-get -y install ipython

echo "Installing arduino"
wget http://arduino.googlecode.com/files/arduino-1.0.5-linux64.tgz -O /tmp/arduino.tgz
sudo tar -xzf /tmp/arduino.tgz -C /opt/

echo "Installing eclipse"
wget http://artfiles.org/eclipse.org//technology/epp/downloads/release/kepler/SR1/eclipse-cpp-kepler-SR1-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz
sudo tar -xzf eclipse.tar.gz -C /opt
sudo apt-get -y install openjdk-7-jre
sudo cp eclipse.desktop /usr/share/applications/eclipse.desktop

echo "Installing sshfs"
sudo apt-get -y install sshfs

echo "Installing wine"
sudo apt-get -y install wine
winetricks vb5run
winecfg

echo "Installing usboscil"
wget http://oscill.com/files/osclb143.zip -O /tmp/oscill.zip
unzip /tmp/oscill.zip -d /home/$USER/.wine/drive_c/
ln -s /dev/ttyUSB0 /home/$USER/.wine/dosdevices/com1
sudo usermod -a -G dialout $USER
sudo cp usboscil.desktop /usr/share/applications/usboscil.desktop
