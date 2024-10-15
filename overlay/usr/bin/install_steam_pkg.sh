#!/usr/bin/env bash

echo "**** Installing/upgrading Steam package ****"

mkdir -p ${USER_HOME}/.steam/debian-installation/package

pkg=(
steamui_websrc_all.zip.vz.deeae77fea80a3110c15d0e9a63c2a95ab6ab647_24679493
resources_misc_all.zip.vz.e86a975545f3ab21a77373870cb311ef93934b8c_2224876
public_all.zip.vz.b0ad1267ec973fc34840c92ebbf4b35b0c40cc17_23591292
steamui_websrc_sounds_all.zip.vz.a2b25775b33d943e54c45d176558de379111ef5f_3220470
bins_ubuntu12.zip.vz.f83baf36035930788f01ab03017d333af41dad5c_30138834
bins_sdk_ubuntu12.zip.vz.c30c0a3a11027dd16cabaa3512e15615dd0d4dde_19880133
bins_codecs_ubuntu12.zip.vz.16bd95e339abaabf87d7d50ed4822fc0d67b590d_8752315
bins_misc_ubuntu12.zip.vz.72be98aad8e15e7b92bfccfe7c4268b720870b9c_18827909
webkit_ubuntu12.zip.vz.57c0e0d3866ff0cdaa4af1f0fb2a0393a31a7906_79943183
runtime_scout_ubuntu12.zip.2422dc5093c67022c86b17493e49f66124f182d0
runtime_sniper_ubuntu12.zip.328e060d569aa12d70746dab1f74cd54196edf9c
)

for p in ${pkg[@]}; do
    if [[ -f ${USER_HOME}/.steam/debian-installation/package/$p ]]; then
        echo "Downloading [${p}] ... "
        wget -O ${USER_HOME}/.steam/debian-installation/package/$p http://media.steampowered.com/client/$p
    fi
done

echo "DONE"
