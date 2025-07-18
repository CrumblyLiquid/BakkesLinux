#!/usr/bin/env bash

# WARNING! Steam runs scripts like this with `/bin/sh -c "/path/to/this/script.sh"` and not bash
# sh handles some things differently
# (e.g. spaces in paths -> we have to wrap every path variable with double quotes)

# Set Rocket League launch options to `"/path/to/this/script.sh" & %command%`
# Put any other launch options before `%command%` like normal

# Run this script with --skip-checks to skip the "is Rocket League running" checks
# This can be useful if you want to launch BakkesMod on its own
# to for example update BakkesMod without the script closing BakkesMod after RL closes

SKIP_CHECKS=false
if [ $# -ge 1 ] && [ "$1" = "--skip-checks" ]; then
    SKIP_CHECKS=true
fi

# WINEPREFIX for Rocket League
RL_PREFIX="$HOME/.steam/steam/steamapps/compatdata/252950"

# Detect what Proton version was used last
# $() evaluates the command in parentheses
# sed -n 4p prints the 4th line in config_info
# xargs -d '\n' split the string given by sed and executes `dirname` on each part
# dirname simply returns parent of the path
# Resulting in the path to the Proton version used to run Rocket League
PROTON="$(sed -n 3p "$RL_PREFIX"/config_info | xargs -d '\n' dirname)"

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
    if ! $SKIP_CHECKS; then
        while ! pgrep RocketLeague 2> /dev/null; do
            # The `sleep` command spawns a process every time
            # we execute it
            # sleep 1

            # That's why I'm using this workoround
            # https://unix.stackexchange.com/a/120229
            read -t 1 <&1 3<&- 3<&0 <&3
        done

        # Retrieve the Rocket League process ID so we can check
        # when it closes later
        GAME_PID="$(pgrep RocketLeague)"
    fi

    # Open BakkesMod with the correct Proton version and Wine prefix
    # Doesn't require protontricks 
    BAKKES_PID="-1"
    if [ "$WINESYNC" = "E" ]; then
        echo "IMPORTANT! Running BakkesMod with WINEESYNC=1" 
        echo "IMPORTANT! If BakkesMod fails to launch, try switching to WINEFSYNC=1"
        WINEESYNC=1 WINEPREFIX="$RL_PREFIX/pfx" "$PROTON/bin/wine64" "$BAKKES" &
        BAKKES_PID=$!
    else
        echo "IMPORTANT! Running BakkesMod with WINEFSYNC=1" 
        echo "IMPORTANT! If BakkesMod fails to launch, try switching WINEESYNC=1"
        WINEFSYNC=1 WINEPREFIX="$RL_PREFIX/pfx" "$PROTON/bin/wine64" "$BAKKES" &
        BAKKES_PID=$!
    fi

    # BakkesMod doesn't launch with the approach above on NixOS
    # and this is a possible workaround
    # protontricks-launch --appid 252950 "$BAKKES" &

    # Kill BakkesMod process when Rocket League is closed
    if ! $SKIP_CHECKS; then
        # Wait until Rocket League closes
        tail --pid="$GAME_PID" -f /dev/null
        kill "${BAKKES_PID}"
    fi
else
    echo "$BAKKES doesn't exist! ABORTING!"
fi
