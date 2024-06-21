# Running BakkesMod on Linux via Proton/Wine

This is a guide to help you set up BakkesMod for Rocket League on Linux. It will show you how to install and run BakkesMod with an up to date version of Rocket League through the [Proton](https://github.com/ValveSoftware/Proton/)/[Wine](https://www.winehq.org/) compatibility layer.

If you're on the **Steam Deck** start [here](STEAMDECK.md), otherwise continue on :)

> [!WARNING]
> This guide is very Steam centric (as that's what I use) but the concepts apply to different launchers as well.
>
> If you have experience with different launchers and want to share it, check out [Contributing](#contributing).

> [!IMPORTANT]
> Using Proton is only recommended if you're running Rocket League through Steam. If that's not the case using Wine or [Wine-GE](https://github.com/GloriousEggroll/wine-ge-custom) is advised as using Proton outside of Steam can cause issues.

## Setup

### Download BakkesMod
Download `BakksModSetup.zip` from the [official website](https://bakkesmod.com/) or [GitHub repository](https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases).

Extracting the archive will yield `BakkesModSetup.exe`.

### Choose an installation path

You can either:
1. Install `protontricks` (**preferred option for Steam users**)

> [!WARNING]
> Use this option **only with Proton** (not Wine, Wine-GE or other options)

2. Install `winetricks`
3. Use plain `wine` (don't install Wine yourself, use the one that's used by your launcher to launch Rocket League)

### Finding wine prefix

You'll need to **find what [wine prefix](https://wiki.archlinux.org/title/wine#WINEPREFIX) the game is running in**.

> [!TIP]
> On Steam this is usually `~/.steam/steam/steamapps/compatdata/252950/pfx` or a similar path (note that the AppID of Rocket League on Steam is `252950`). Once again for other installations you'll have to find this yourself.

### Finding Wine/Proton folder

You'll need to **find the path to Proton/Wine** that is used for Rocket League. 

> [!TIP]
> On Steam this can be achieved by inspecting `~/.steam/steam/steamapps/compatdata/252950/config_info` and noting the path on the 4. line without the last directory (the result should end with `/dist`). For me it's `~/.local/share/Steam/steamapps/common/Proton 7.0/dist` for example.
>
> You can achieve that with this command: `sed -n 4p ~/.steam/steam/steamapps/compatdata/252950/config_info | xargs -d '\n' dirname`
>
> For installations other than Steam (e.g. Lutris, Heroic, Bottles, ...) you'll have to find this yourself.

## Installation
> [!NOTE]
> Replace `your_prefix` with the one you obtained in [Finding wine prefix](#finding-wine-prefix)
> 
> Replace `wine_folder` with the one you obtained in [Finding Wine/Proton folder](#finding-wineproton-folder)

### Configuring wine prefix

To be able to run `BakkesModSetup.exe` we need to **change the Windows version of our prefix to Windows 10**.

1. Using `protontricks`: `protontricks 252950 win10`
2. Using `winetricks`: `WINEPREFIX="your_prefix" winetricks win10`
3. Using `wine`: Run `WINEPREFIX="your_prefix" winecfg` and set `Windows Version` to `Windows 10`

### Running BakkesModSetup.exe

Now run the the previously downloaded `BakkesModSetup.exe`.

1. Using `protontricks`: `protontricks-launch --appid 252950 ~/Downloads/BakkesModSetup.exe`
2. Using `wine`: `WINEPREFIX="your_prefix" "wine_folder/bin/wine64" ~/Downloads/BakkesModSetup.exe`

This should start the BakkesMod installer. Go through the installation as you normally would.

> [!WARNING]
> You'll probably have to enable the executable flag for `BakkesModSetup.exe`.
> 
> You can do so by running `chmod u+x ~/Downloads/BakkesModSetup.exe`

## Running BakkesMod

### Manually

After starting Rocket League you can launch BakkesMod in the same way as running `BakkesModSetup.exe`.
1. Using `protontricks`: `protontricks-launch --appid 252950 "your_prefix/drive_c/Program Files/BakkesMod/BakkesMod.exe"`
2. Using `wine`: `WINEPREFIX="your_prefix" "wine_folder/bin/wine64" "your_prefix/drive_c/Program Files/BakkesMod/BakkesMod.exe"`

> [!WARNING]
> You might see this message: `Mod is out of date, waiting for an update`.
>
> To work around it, you'll have to go to `Settings` and disable `Enable safe mode`. You'll be prompted with a warning before injecting.

> [!TIP]
> You can find the path to `BakkesMod.exe` using this command: `find ~ -name "BakkesMod.exe" 2> /dev/null`
> 
> The path should probably end with `drive_c/Program Files/BakkesMod/BakkesMod.exe`

### Automatically

#### With Steam Tinker Launch

You can start BakkesMod automatically with [Steam Tinker Launch](https://github.com/sonic2kk/steamtinkerlaunch) via the _Custom Game Executable_ feature.

#### With a custom launch script

> [!NOTE]
> This script **works only on Steam** but it shouldn't be hard to make it work on other launchers as well.

1. Create a file somewhere in your home directory and make it executable (you can do so with `chmod +x /path/to/the/script.sh`)
2. Paste in the contents of [bakkes.sh](./bakkes.sh) or make your own launch script.

> [!WARNING]
> You might have to change some paths if you're using [bakkes.sh](./bakkes.sh).

3. In Steam go to `Library` and find Rocket League in the menu on the left. Right-click on it and select `Properties`
4. In the `General` tab you will see `Launch options` text field. Set that to `"/path/to/the/script.sh" & %command%` (you can put any other launch options before `%command%`)

> [!WARNING]
> You might have to use absolute path to the script (also without `"$HOME"` or `~`).

**And that's it!** You should now have a working BakkesMod installation that will launch alongside Rocket League and close when Rocket League does.

## My setup

As of right now I'm running Rocket League on Steam via Proton 7.0.

I've written an [install script](./install.sh) that requires `protontricks` to run. It downloads and runs the setup executable. It also sets the `Launch options` in Steam to execute [`bakkes.sh`](./bakkes.sh)

> [!WARNING]
> I haven't tested this in a while and I'm not sure if it works.

## Contributing

If you find any errors or have anything to add I'll be hapy to update this guide.

You can let me know by [creating an issue](https://github.com/CrumblyLiquid/BakkesLinux/issues/new).

## Sources

I've mainly used this issue https://github.com/bakkesmodorg/BakkesMod2-Plugins/issues/2 to make my installation work. There is a lot more covered there than I've shown here. Thanks to all the people who have shared their solutions there!
