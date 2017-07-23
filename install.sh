#!/usr/bin/env bash

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
  read -p "Run it?" nyan
  if [ ! -z "$nyan" ];then
    npm start&
    unset nyan;
    exit 0;
  fi

}
