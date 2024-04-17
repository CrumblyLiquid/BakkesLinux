#!/usr/bin/env bash

# WINEDEBUG=-all suppresses debugging info
# Change this if you're running into issues and want to see all the logging
export WINEDEBUG=-all

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

ZIP="$SCRIPT_DIR/BakkesModSetup.zip"
E_ZIP="$SCRIPT_DIR/BakkesModSetup" # Extracted zip folder

URL="https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip"

# Check if commands needed to run this script are present
commands=(
    "dirname" "mkdir" "rm" "curl" "unzip" "killall" "sleep"
    "protontricks" "protontricks-launch"
    # Python is also needed but only for setting the launch options
    # so it's not checked here
)

for cmd in ${commands[@]}; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "${cmd} is required but not installed!"
        exit 1
    fi
done


# Either download the exe directly or download an archive
# curl -Lo "$SCRIPT_DIR/BakkesModSetup.exe" $URL
echo "INFO: Downloading BakkesModSetup.zip from $URL"
curl -Lo "$ZIP" "$URL"
# Make a folder to which we want to extract BakkesModSetup.zip
# -p = Create parent directories as needed
mkdir -p "$E_ZIP"
# -d = Directory to which to extract files
unzip -d "$E_ZIP" "$ZIP"
# Delete BakkesModSetup.zip
rm "$ZIP"

echo "INFO: Waiting for RocketLeague to exit"
echo "INFO: You have to manually close Rocket League in order to modify the prefix"
while killall -0 RocketLeague.exe &> /dev/null; do
    sleep 1
done

# TODO: Check if that WINEPREFIX is in use
# pgrep -fl wineserver
echo "INFO: Configuring prefix"
# Set the WINEPREFIX used by RocketLeague to Windows10 so we can install BakkesMod
protontricks 252950 -q win10

echo "INFO: Running BakkesMod setup executable"
# Make installer executable
chmod u+x "$E_ZIP/BakkesModSetup.exe"
# Run BakkesMod installer
protontricks-launch --appid 252950 "$E_ZIP/BakkesModSetup.exe"


read -p "QUESTION: Do you want to set launch options for RocketLeague? (y/n) " yn
case "$yn" in 
    y|Y )
        echo "INFO: Waiting for Steam to exit"
        echo "INFO: You have to manually close Steam to be able to set launch options"
        while killall -0 steam &> /dev/null; do
            sleep 1
        done

        # Set launch options by modifyng localconfig.vdf
        echo "INFO: Setting Rocket League launch options in Steam"
        echo "INFO: Modifying localconfig.vdf"
        python "$SCRIPT_DIR/modcfg.py";&
    n|N )
        echo "INFO: Installation complete";;
    * )
        echo "ERROR: Invalid response.";;
esac
