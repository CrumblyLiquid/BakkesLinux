# Running BakkesMod on Linux via Proton

It's possible to run BakkesMod on Linux with an up to date version of Rocket League through the [Proton](https://github.com/ValveSoftware/Proton/)/[Wine](https://www.winehq.org/).

Using Proton is only recommended if you're running Rocket League through Steam. If that's not the case using Wine or [Wine-GE](https://github.com/GloriousEggroll/wine-ge-custom) is advised as using Proton outside of Steam can cause issues.

## Steam Deck

Please see the `README_steamdeck.md` file for instructions to install on Valves Steam Deck.

## Installation

### Setup
Download `BakksModSetup.zip` from the [official website](https://bakkesmod.com/) or [GitHub repository](https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases).

Extracting the archive will yield `BakkesModSetup.exe`.

### Find Wine/Proton folder

First you'll need to find the path to Proton/Wine that is used for Rocket League. 

On Steam this can be achieved by inspecting `~/.steam/steam/steamapps/compatdata/252950/config_info` and noting the path on the 4. line without the last directory (the result should end with `/dist`). For me it's `~/.local/share/Steam/steamapps/common/Proton 7.0/dist` for example.

For installations other than Steam (e.g. Lutris, Heroic, Bottles, ...) you'll have to find this yourself.

### Find wine prefix

Then you'll need to find what Wineprefix is the game running in.

On Steam this is usually `~/.steam/steam/steamapps/compatdata/252950/pfx` or a simmilar path (note that the AppID of Rocket League on Steam is `252950`). Once again for other installations you'll have to find this yourself.

### Configure wine prefix

To be able to run `BakkesModSetup.exe` we need to change the Windows version of our prefix to Windows 10.

There are multiple ways to do this.
1. Run `WINEPREFIX="your_prefix" winecfg` (replace `your_prefix` with the one you obtained in [Find wine prefix](#find-wine-prefix)) and set `Windows Version` to `Windows 10`. 
2. Install `winetricks` and run `WINEPREFIX="your_prefix" winetricks win10`
3. Install `protontricks` (use protontricks only if you're using Proton and not Wine-GE for example) and run `protontricks 252950 win10`

### Run BakkesModSetup.exe

Now run the the previously downloaded `BakkesModSetup.exe`.

Again there are multiple options:
1. `WINEPREFIX="your_prefix" "wine_folder/bin/wine64" ~/Downloads/BakkesModSetup.exe` (replace `your_prefix` and `wine_folder` with the values you've found in [Find Wine/Proton folder](#find-wineproton-folder) and [Find wine prefix](#find-wine-prefix) and change the path to `BakkesModSetup.exe`)
2. Use protontricks: `protontricks -c "$HOME/Downloads/BakkesModSetup.exe" 252950`

Now go through the installation process (I recommend you don't change the default installation path as it might come in handy later when setting up automatic launch and close script)

## Running BakkesMod

### Manually

After starting Rocket League you can launch BakkesMod in the same way as running `BakkesModSetup.exe`.
1. `WINEPREFIX="your_prefix" "wine_folder/bin/wine64" "your_prefix/drive_c/Program Files/BakkesMod/BakkesMod.exe"`
2. Use `winetricks`: `WINEPREFIX="your_prefix" winetricks -c "your_prefix/drive_c/Program Files/BakkesMod/BakkesMod.exe"`
3. Use `protontricks`: `protontricks -c "your_prefix/drive_c/Program Files/BakkesMod/BakkesMod.exe" 252950`

### Automatically

I'll go over doing this on Steam but you can easily adapt this scipt for other installations as well.

1. Create a file somewhere in your $HOME and make it executable (you can do so with `chmod +x /path/to/the/script.sh`)
2. Copy+paste the contents of [bakkes.sh](./bakkes.sh) (you'll maybe have to change some paths to get it to work) or make your own launch script.
3. In Steam go to `Library` and find Rocket League in the menu on the left. Right-click on it and select `Properties`
4. In the `General` tab you will see `Launch options` text field. Set that to `"/path/to/the/script.sh" & %command%` (you can put any other launch options before `%command%`)

And that's it! You should now have a working BakkesMod installation that will launch alongside Rocket League and close when Rocket League does.

## My setup

As of right now I'm running Rocket League on Steam via Proton 7.0.

I've written an [install script](./install.sh) that requires `protontricks` to run (I might rewrite it at some point to support any wine prefix and wine/proton version). It downloads and runs the setup executable. It also sets the `Launch options` in Steam to execute [`bakkes.sh`](./bakkes.sh)

## Contributing

I haven't tested all the options of installing and running BakkesMod as I'm only running Rocket League through Steam. If you find any errors or have anything to add I'll be hapy to update this README. You can either create a PR or contact me directly.

## Sources

I've mainly used this issue https://github.com/bakkesmodorg/BakkesMod2-Plugins/issues/2 to make my installation work. There is a lot more covered there than I've shown here. Thanks to all the people who have shared their solutions there!
