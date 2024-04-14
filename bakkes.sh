#!/usr/bin/env bash

# WARNING! Steam runs scripts like this with `/bin/sh -c "/path/to/this/script.sh"` and not bash
# sh handles some things differently
# (e.g. spaces in paths -> we have to wrap every path variable with double quotes)

# Set Rocket League launch options to `"/path/to/this/script.sh" & %command%`
# Put any other launch options before `%command%` like normal

# WINEPREFIX for Rocket League
RL_PREFIX="$HOME/.steam/steam/steamapps/compatdata/252950"

# Detect what Proton version was used last
# $() evaluates the command in parentheses
# sed -n 4p prints the 4th line in config_info
# xargs -d '\n' split the string given by sed and executes `dirname` on each part
# dirname simply returns parent of the path
# Resulting in the path to the Proton version used to run Rocket League
PROTON="$(sed -n 4p "$RL_PREFIX"/config_info | xargs -d '\n' dirname)"

# This is the default BakkesMod installation path
# Change this if you've installed Bakkes somewhere else
BAKKES="$RL_PREFIX/pfx/drive_c/Program Files/BakkesMod/BakkesMod.exe"

# Use WINEESYNC (E) or WINEFSYNC (F)
# This needs to match the one RocketLeague is launched with
# fsync requires support in the kernel
WINESYNC="F"

# Check that BakkesMod.exe exists
if [ -f "$BAKKES" ]; then
    # Start BakkesMod when Rocket League starts
    # killall -0 sends no signal but still performs error checking
    # that way we can detect if a program is running or not
    while ! killall -0 RocketLeague.exe 2> /dev/null; do
        sleep 1
    done

    # Open BakkesMod with the correct Proton version and Wine prefix
    # Doesn't require protontricks 
    if [ "$WINESYNC" = "E" ]; then
        echo "IMPORTANT! Running Rocket League with WINEESYNC=1" 
        echo "IMPORTANT! If BakkesMod fails to launch, switch to WINEFSYNC=1"
        WINEESYNC=1 WINEPREFIX="$RL_PREFIX/pfx" "$PROTON/bin/wine64" "$BAKKES" &
    else
        echo "IMPORTANT! Running Rocket League with WINEFSYNC=1" 
        echo "IMPORTANT! If BakkesMod fails to launch, switch to WINEESYNC=1"
        WINEFSYNC=1 WINEPREFIX="$RL_PREFIX/pfx" "$PROTON/bin/wine64" "$BAKKES" &
    fi

    # Kill BakkesMod process when Rocket League is closed
    while killall -0 RocketLeague.exe 2> /dev/null; do
        sleep 1
    done
    killall BakkesMod.exe
else
    echo "$BAKKES doesn't exist! ABORTING!"
fi
