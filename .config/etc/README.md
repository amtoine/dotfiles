This is a mirror of the configured parts of the `/etc/` directory.  
These are the first things than one is able to see when booting, let us try to make them pretty.

Do not forget to reboot after installation.

# `grub`
Install, see the [catppuccin repo](https://github.com/catppuccin/grub):
```bash
git clone https://github.com/catppuccin/grub.git /tmp/catppuccin-grub
sudo cp -r /tmp/catpuccing-grub/catppuccin-grub-theme /usr/share/grub/themes/
sudo cp /path/to/a2n-s/dotfiles/.config/etc/default/grub /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
| ![grub-catppuccin](https://raw.githubusercontent.com/catppuccin/grub/main/assets/cat-grub.png) |
|:--:|
| *The `grub` menu with the **catppuccin** theme.* |


# `issue` on `tty`x
Install:
```bash
sudo cp /path/to/a2n-s/dotfiles/.config/etc/issue /etc/issue
```
example welcome prompt on `tty2`:
```
Welcome to Arch Linux on <hostname> (<kernel>) (tty2)

+---------------------------------+
| It is hh:mm:ss, Sun Feb 20 2022 |
+---------------------------------+

                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/

login: |
```

# the `sddm` login manager
Install:
```bash
sudo pacman -S sddm
tar -xzvf /path/to/a2n-s/dotfiles/.config/etc/sddm-catppuccin.tar.gz
sudo mv sddm-catppuccin /usr/share/sddm/themes/catppuccin
sudo cp /path/to/a2n-s/dotfiles/.config/etc/sddm.conf /etc/sddm.conf
sudo systemctl enable sddm
sudo systemctl start sddm
```
| ![sddm-catppuccin](sddm-catppuccin.png) |
|:--:|
| *The `sddm` login manager with the **catppuccin** theme.* |
