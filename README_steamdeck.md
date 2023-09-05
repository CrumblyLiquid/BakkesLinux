# Steam Deck

You will need to be in Desktop Mode (Hold Power Button, then `Switch To Desktop`).
 
You will need to download [protontricks](https://flathub.org/apps/com.github.Matoking.protontricks) from flatpak, which can be done through the discover app on your deck. 

Installing [GE-Proton](https://github.com/GloriousEggroll/proton-ge-custom) is recommended on the Steam Deck for better performance and compatability. If you install via [NonSteamLaunchers For Steam Deck](https://github.com/moraroy/NonSteamLaunchers-On-Steam-Deck), this should be done for you automatically.  

## Installation with Rocket League Through Steam
If you want to use Non-Steam Launchers, look at the section below for installation instructions.

Download `BakkesModSetup.zip` from the [official website](https://bakkesmod.com/) or [GitHub repository](https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases).

Extracting the archive will yield `BakkesModSetup.exe`.

Now, run the following `protontricks` command in the "Konsole" to switch the environment to Windows 10: `protontricks 252950 win10` (note that the AppID of Rocket League on Steam is `252950`. Non-Steam-Launchers will be different, see below. Custom Installs will also be different).

We will now run that previously downloaded `BakkesModSetup.exe` using the following command: `protontricks -c "$HOME/Downloads/BakkesModSetup.exe" 252950`. 
Now go through the installation process (I recommend you don't change the default installation path as it might come in handy later when setting up automatic launch and close script).

#### Running Automatically

1. Create a file somewhere in your $HOME and make it executable (you can do so with `chmod +x /path/to/the/script.sh`)
2. Copy+paste the contents of [bakkes.sh](./bakkes.sh).
3. In Steam go to `Library` and find Rocket League in the menu on the left. Right-click on it and select `Properties`
4. In the `General` tab you will see `Launch options` text field. Set that to `"/path/to/the/script.sh" & %command%` (you can put any other launch options before `%command%`)

Running Rocket League now should also enable BakkesMod. You can switch back to Gaming Mode now.
## Non-Steam Launchers on Steam Deck
This is for users who installed the offical `Epic Games Launcher` through [Non-Steam Launchers](https://github.com/moraroy/NonSteamLaunchers-On-Steam-Deck).

You can start off by downloading the Epic Games Launcher through Non-Steam Launchers. You will then have to fully exit out of Steam, and then re-open it to see the Epic Games launcher show up in your library. From here, you can launch the Epic Games Launcher, login, and install Rocket League. 

You should also make sure that you import Rocket League into Steam (after downloading via the official Epic Games Launcher) by using the `Find Games` button. 
> This button can be found at the bottom when you run Non-Steam Launchers

You will have to fully exit out of Steam again, and re-open it. 


Once downloaded, you must close out the launcher, and run the following command to find the APPID of your Epic Games Launcher. 

To find the APPID of your Epic Games Launcher, run `protontricks -s Epic Games` in the "Konsole" and it will show `Epic Games (APPID)`. Note down this APPID. 

Download `BakkesModSetup.zip` from the [official website](https://bakkesmod.com/) or [GitHub repository](https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases).

Extracting the archive will yield `BakkesModSetup.exe`.

We will now configure our wine environment to be windows 10. You can do this by running the following command in the "Konsole": `protontricks APPID win10`

### Running BakkesMod

To run through the BakkesMod installation, run the following command: `protontricks -c "$HOME/Downloads/BakkesModSetup.exe" APPID`

Leave all of the default installation paths, and just keep clicking `Next`. 

When installation finishes, you can close the BakkesMod window. 

#### Running Automatically

1. Create a file somewhere in your $HOME and make it executable (you can do so with `chmod +x /path/to/the/script.sh`)
2. Copy+paste the contents of [bakkes.sh](./bakkes.sh). You will have to change the `RL_PREFIX` variable to be `RL_PREFIX="$HOME/.steam/steam/steamapps/compatdata/APPID"`
3. In Steam go to `Library` and find Rocket League in the menu on the left. Right-click on it and select `Properties`
4. In the `General` tab you will see `Launch options` text field. Set that to `"path/to/the/script.sh" & STEAM_COMPAT_DATA_PATH="/home/deck/.steam/steam/steamapps/compatdata/APPID" %command%` (DONT FORGET TO CHANGE THE APPID)

Running Rocket League now should also enable BakkesMod. You can switch back to Gaming Mode now.

# Binding F2 and ESC

I suggest binding some buttons on the controller using Steam Input to be the keyboard `F2` (open GUI) and `ESC`. When you are in the menu, you can hold down the `STEAM` button and use the right trackpad and triggers to use a mouse. 
