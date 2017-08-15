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

  if [[ -z $user_inst ]]; then
    printf "What user do you want to run Wire with?\n> ";read user_inst
    while [[ -z $user_inst ]]; do
      printf "Please, enter a user name\n> "
      read user_inst
    done
  fi

  cd /opt;
  git clone https://github.com/wireapp/wire-desktop
  cd wire-desktop;
  npm install;
  chown -R $user_inst:$user_inst /opt/wire-desktop;
  echo 'alias "wire"="cd /opt/wire-desktop/ && npm start&"'>>\
  /home/$user_inst/.bashrc;
}

all_install(){
  deps;nodeJS_install;wire-desktop;
}

wire(){
  cd /opt/wire-desktop && npm start&;
}
