#!/bin/bash
$1/steamcmd.sh +login anonymous +force_install_dir $2/kf2server +app_update 232130 +quit

$2\kf2server\Binaries\win64\kfserver kf-bioticslab
