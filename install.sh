# Update
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Install tools for building dependencies
sudo pacman -S git nushell

# Clone dotfiles
git clone --bare https://github.com/atxr/dotfiles-1 .dotfiles
git clone https://github.com/amtoine/pkgbuilds
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
cfg reset --hard
cfg config --local status.showUntrackedFiles no
cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Build pkgbuilds
cd pkgbuilds
./install.sh x86_64/paru x86_64/amtoine-scripts-git/ x86_64/amtoine-sounds-git/ x86_64/amtoine-wallpapers-git/ x86_64/amtoine-applications-git/ x86_64/amtoine-icons-git/
cd
sudo rm -r pkgbuilds

# Install dependencies
nu -c 'paru -S (open pkgs.toml | get pkgs.pacman.native.package)'

# Install dmenu-flexipatch
git clone https://github.com/bakkeby/dmenu-flexipatch dmenu
cp .config/dmenu-flexipatch/patches.h dmenu
cd dmenu 
make clean install
cd 
sudo rm -r dmenu

# Activate useful system
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Greet
echo 'Installation completed! Please reboot your computer.'

