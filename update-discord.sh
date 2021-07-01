#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
FILENAME="$DIR/latest_discord.tar.gz";

read -p '# Which version do you want to update? Please type STABLE, PTB, or CANARY : ' version
version=${version^^}

if [ "$version" = "STABLE" ] || [ "$version" = "CANARY" ]; then
    INSTALLPATH="/usr/share/discord";
    FOLDERNAME="Discord";
    if [ "$version" = "CANARY" ]; then
        URL="https://canary.discord.com/api/download?platform=linux&format=tar.gz";
    else
        URL="https://discord.com/api/download?platform=linux&format=tar.gz";
    fi
    echo "## Closing Discord ...";
    for pid in $(pidof Discord); do kill -9 $pid; done
    echo "## Discord instance(s) closed.";
    if test -d "$INSTALLPATH"; then
        sudo rm -rf $INSTALLPATH;
        echo "## Removed last installed version.";
    fi
    if test -e "$FILENAME"; then
        rm $FILENAME;
        rm -rf $FOLDERNAME;
        echo "## Removed last downloaded version.";
    fi
    echo "## Downloading latest version of Discord is starting...";
    wget -q --show-progress -O $FILENAME $URL;
    echo "## Downloading finished.";
    echo "## Extracting..";
    tar -xzf $FILENAME;
    echo "## Installing latest version...";
    sudo cp $FOLDERNAME/discord.png /usr/share/pixmaps;
    sudo rm -rf /usr/share/applications/discord.desktop
    sudo cp $FOLDERNAME/discord.desktop /usr/share/applications;
    sudo mkdir -p $INSTALLPATH;
    sudo cp -a $FOLDERNAME/. $INSTALLPATH;
    echo "## Installation finished.";
elif [ "$version" = "PTB" ]; then
    INSTALLPATH="/usr/share/discord-ptb";
    URL="https://discord.com/api/download/ptb?platform=linux&format=tar.gz"
    FOLDERNAME="DiscordPTB";
    echo "## Closing Discord ...";
    for pid in $(pidof DiscordPTB); do kill -9 $pid; done
    echo "## Discord instance(s) closed.";
    if test -d "$INSTALLPATH"; then
        sudo rm -rf $INSTALLPATH;
        echo "## Removed last installed version.";
    fi
    if test -e "$FILENAME"; then
        rm $FILENAME;
        rm -rf $FOLDERNAME;
        echo "## Removed last downloaded version.";
    fi
    echo "## Downloading latest version of Discord is starting...";
    wget -q --show-progress -O $FILENAME $URL;
    echo "## Downloading finished.";
    echo "## Extracting..";
    tar -xzf $FILENAME;
    echo "## Installing latest version...";
    sudo cp $FOLDERNAME/discord.png /usr/share/pixmaps;
    sudo rm -rf /usr/share/applications/discord-ptb.desktop
    sudo cp $FOLDERNAME/discord-ptb.desktop /usr/share/applications;
    sudo mkdir -p $INSTALLPATH;
    sudo cp -a $FOLDERNAME/. $INSTALLPATH;
    echo "## Installation finished.";
else
    echo "Unfortunately, there is no version that you typed.";
    exit;
fi

exit;