# KF2Docker

With this files you can start a Container with a Killing Floor 2 Gameserver inside.

Current State: Not Working
Im Working on it

Start
=====

First download this repo

    git clone https://github.com/Blackatx/kf2docker
 
A folder names kf2docker appears

    cd kf2docker

Build the image

    docker build -t kf2server .

It takes a while becouse the KF2 Server file are 16 GB big.

ToDo
====

1. Make sure that the Container works properly
2. Add Volume so Config can be customized outside of the Container
3. Make sure the Web Interface is working
4. Add Volume for Custom Stuff (like Maps)
