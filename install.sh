#!/usr/bin/env bash

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ZIP="$SCRIPT_DIR/BakkesModSetup.zip"
E_ZIP="$SCRIPT_DIR/BakkesModSetup" # Extracted zip folder

URL="https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip"

# Either download the exe directly or download an archive
# curl -Lo "$SCRIPT_DIR/BakkesModSetup.exe" $URL

echo "INFO: Downloading BakkesModSetup.zip from $URL"
curl -Lo $ZIP $URL
mkdir -p $E_ZIP
unzip -d $E_ZIP $ZIP
rm $ZIP

echo "INFO: Waiting for RocketLeague to exit"
while killall -0 RocketLeague.exe 2> /dev/null; do
    sleep 1
done

echo "INFO: Configuring prefix"
# Set the WINEPREFIX used by RocketLeague to Windows10 so we can install BakkesMod
protontricks 252950 -q win10

echo "INFO: Running BakkesMod setup executable"
# Make installer executable
chmod +x "$E_ZIP/BakkesModSetup.exe"
# Run BakkesMod installer
# WINEDEBUG=-all suppresses debugging info, remove this if you're running into issues
WINEDEBUG=-all protontricks -c "$E_ZIP/BakkesModSetup.exe" 252950

echo "INFO: Waiting for Steam to exit"
while killall -0 steam 2> /dev/null; do
    sleep 1
done

# Set launch options by modifing localconfig.vdf
python "$SCRIPT_DIR/modcfg.py"