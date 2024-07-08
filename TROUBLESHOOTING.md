# Troubleshooting

If you're having trouble running BakkesMod, try skimming through the issues outlined below.

If that doesn't help, try referencing [BakkesLinux Issues](https://github.com/CrumblyLiquid/BakkesLinux/issues)
or the original [BakkesMod on Linux issue](https://github.com/bakkesmodorg/BakkesMod2-Plugins/issues/2)

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
