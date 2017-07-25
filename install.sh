#!/usr/bin/env bash
user_inst=
deps(){
  apt install git -y;
}

nodeJS_install(){
  git clone https://github.com/nodejs/node
  cd node;
  ./configure
  p=$(nproc)
  make -j$p || exit 1;
  make install || exit 2;
  unset p;
}

wire_install(){
  if [ ! -d /opt/ ];then
    mkdir -p /opt/;
  fi

  cd /opt;
  git clone https://github.com/wireapp/wire-desktop
  cd wire-desktop;
  npm install;
  chown -R $user_inst:$user_inst /opt/wire-desktop;
  echo 'alias "wire"="cd /opt/wire-desktop/ && npm start&"'>\
  /home/$user_inst/.bashrc;
}

all_install(){
  deps;nodeJS_install;wire-desktop;
}

wire(){
  cd /opt/wire-desktop && npm start&;
}
