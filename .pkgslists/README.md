| Filename             | Command used                                                | Description                                 |
|----------------------|-------------------------------------------------------------|---------------------------------------------|
| `allpkglist.txt`     | `pacman -Qqe`                                               | List of all installed packages.             |
| `pkglist.txt`        | `pacman -Qqent`                                             | List of all native and unrequired packages. |
| `optdeplist.txt`     | `comm -13 <(pacman -Qqdt \| sort) <(pacman -Qqdtt \| sort)` | List of all dependencies.                   |
| `foreignpkglist.txt` | `pacman -Qqem`                                              | List of all foreign (AUR) packages.         |

