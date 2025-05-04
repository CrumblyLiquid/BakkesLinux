# Troubleshooting

If you're having trouble running BakkesMod, try skimming through the issues outlined below.

If that doesn't help, try referencing [BakkesLinux Issues](https://github.com/CrumblyLiquid/BakkesLinux/issues)
or the original [BakkesMod on Linux issue](https://github.com/bakkesmodorg/BakkesMod2-Plugins/issues/2)

## Failure to inject

If you have trouble getting BakkesMod to inject into Rocket League,
you might want to try **disabling** the `Enable safe mode` options
or increase the injection timeout ([source](https://github.com/bakkesmodorg/BakkesMod2-Plugins/issues/2#issuecomment-2849309769)).

## WINEFSYNC/WINEESYNC

If you're trying to launch BakkesMod and you get the following (or simmilar) error:

`Server is running with WINEFSYNC but this process is not, please enable WINEFSYNC or restart wineserver`

Ensure that both Rocket League and BakkesMod are running with the same 'sync' mode.
This can be achieved by prefixing the BakkesMod launch command with `WINEFSYNC=1` or `WINEESYNC=1`.

> [!TIP]
> You can see an example of a launch command for BakkesMod in [bakkes.sh](https://github.com/CrumblyLiquid/BakkesLinux/blob/32b1169847c410c80e1dc0913721af4d97363766/bakkes.sh#L48)

> [!NOTE]
> Taken from [ProtonDB](https://www.protondb.com/help/improving-performance):
>
> **Proton** has had **esync** since its first release,
> which aims to **reduce the performance overhead of Wine**,
> especially in CPU bound scenarios.
>
> **fsync** is a more recent alternative with even better performance improvements.
> However, **you do need a kernel that supports it**.
>
> Within **Steam**, **esync** is enabled by default, and **fsync** is enabled by default if your system supports it.
> In **Lutris**, for **esync** you need to enable in in the runner options,
> and for **fsync** you can add WINEFSYNC=1 as an environmental variable.

## Flatpak

If you've installed **Steam as Flatpak** or installed **`protontricks` as Flatpak**
you might have **problems installing or running** BakkesMod due to the **Flatpak sandboxing**.

For example if you're using the Flatpak version of `protontricks` the installation
will work but BakkesMod won't be able to inject into Rocket League because
of the Flatpak sandbox. ([#12](https://github.com/CrumblyLiquid/BakkesLinux/issues/12))

You can work around this by either using a non-Flatpak version of `protontricks`
or by using one of the other ways of launching BakkesMod
(using the `wine`/`proton` binary directly or using [`bakkes.sh`](./bakkes.sh)).

The same might happen if you're running Steam through Flatpak and are
trying to run `bakkes.sh` throuh the commandline outside of the Flatpak sandbox.
