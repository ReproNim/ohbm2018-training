#!/bin/bash
if [ "$PACKER_BUILDER_TYPE" == "amazon-ebs" ]; then
  echo 'Intalling Ubuntu desktop and VNC access ...'

  # Install desktop  
  sudo apt-get install -y \
    ubuntu-desktop \
    gnome-panel \
    gnome-settings-daemon \
    xfce4 \
    nautilus \
    gnome-terminal \
    vnc4server

  # Instal docker-compose
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # Install config files for ubuntu account
  cd ~
  tar xvfz nitrcce-config.tar.gz

  # Install startup script to run at system start
  sudo sed -i -e 's/exit 0/\/home\/ubuntu\/.config\/nitrcce\/guacamole\/startup.sh; exit 0/g' /etc/rc.local
fi

rm nitrcce-config.tar.gz