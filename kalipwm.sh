#!/bin/bash

# Colors
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Check if the current user is root
if [ "$UID" -eq 0 ]; then
    echo -e "${RED}[-] Cannot be run as root.${RESET}"
    exit 1
else
    # Check if sudo is being used
    if [ -n "$SUDO_USER" ]; then
        echo -e "${RED}[-] Do not use sudo.${RESET}"
        exit 1
    fi
fi

# Banner in green
echo -e "${GREEN}
@@@  @@@   @@@@@@   @@@       @@@  @@@@@@@   @@@  @@@  @@@  @@@@@@@@@@
@@@  @@@  @@@@@@@@  @@@       @@@  @@@@@@@@  @@@  @@@  @@@  @@@@@@@@@@@
@@!  !@@  @@!  @@@  @@!       @@!  @@!  @@@  @@!  @@!  @@!  @@! @@! @@!
!@!  @!!  !@!  @!@  !@!       !@!  !@!  @!@  !@!  !@!  !@!  !@! !@! !@!
@!@@!@!   @!@!@!@!  @!!       !!@  @!@@!@!   @!!  !!@  @!@  @!! !!@ @!@
!!@!!!    !!!@!!!!  !!!       !!!  !!@!!!    !@!  !!!  !@!  !@!   ! !@!
!!: :!!   !!:  !!!  !!:       !!:  !!:       !!:  !!:  !!:  !!:     !!:
:!:  !:!  :!:  !:!   :!:      :!:  :!:       :!:  :!:  :!:  :!:     :!:
 ::  :::  ::   :::   :: ::::   ::   ::        :::: :: :::   :::     ::
 :   :::   :   : :  : :: : :  :     :          :: :  : :     :      :
"

sleep 2
echo -e "[+] Professional hacking environment automation script.${RESET}"
sleep 1
echo -e "[+] @afsh4ck - Follow me on: YouTube, Instagram, TikTok"
sleep 3
echo -e "\n${BLUE}[*] Setting up the installation..${RESET}\n"
sleep 3

RPATH=`pwd`

# Update packages
echo -e "\n${BLUE}[*] Updating packages..${RESET}\n"
sudo apt update

# Install packages
echo -e "\n${BLUE}[*] Installing packages..${RESET}\n"
sudo apt install -y git bspwm vim feh scrot scrub zsh rofi xclip xsel locate wmname acpi sxhkd \
    imagemagick ranger kitty tmux python3-pip font-manager lsd bat bpython open-vm-tools-desktop open-vm-tools fastfetch \
    dirsearch feroxbuster gedit

# Install environment dependencies
echo -e "\n${BLUE}[*] Installing environment dependencies..${RESET}\n"
sudo apt install -y build-essential libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Install polybar requirements
echo -e "\n${BLUE}[*] Installing polybar requirements..${RESET}\n"
sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev \
    libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev \
    libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Install picom dependencies
echo -e "\n${BLUE}[*] Installing picom dependencies..${RESET}\n"
sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
    libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev \
    libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev \
    uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

# Install Hack Nerd Font
echo -e "\n${BLUE}[*] Installing fonts..${RESET}\n"
mkdir -p /tmp/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O /tmp/fonts/Hack.zip
unzip -q /tmp/fonts/Hack.zip -d /tmp/fonts
mkdir -p ~/.local/share/fonts
mv /tmp/fonts/*.ttf ~/.local/share/fonts/
rm -rf /tmp/fonts
fc-cache -fv

# Install JetBrains Mono Nerd Font
mkdir -p /tmp/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O /tmp/fonts/JetBrainsMono.zip
unzip -q /tmp/fonts/JetBrainsMono.zip -d /tmp/fonts
mv /tmp/fonts/*.ttf ~/.local/share/fonts/
rm -rf /tmp/fonts
fc-cache -fv

# Install Iosevka Nerd Font (used by kitty)
mkdir -p /tmp/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip -O /tmp/fonts/Iosevka.zip
unzip -q /tmp/fonts/Iosevka.zip -d /tmp/fonts
mv /tmp/fonts/*.ttf ~/.local/share/fonts/
rm -rf /tmp/fonts
fc-cache -fv

# Install oh-my-zsh
echo -e "\n${BLUE}[*] Installing OhMyZSH..${RESET}\n"
rm -rf ~/.oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
echo -e "\n${BLUE}[*] Installing powerlevel10k theme..${RESET}\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm -f ~/.p10k.zsh
cp -v $RPATH/CONFIGS/p10k.zsh ~/.p10k.zsh

# Install zsh plugins
echo -e "\n${BLUE}[*] Installing ZSH plugins..${RESET}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -f ~/.zshrc
cp -v $RPATH/CONFIGS/zshrc ~/.zshrc

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# .tmux
echo -e "\n${BLUE}[*] Installing tmux..${RESET}\n"
rm -rf ~/.tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/
cp -v $RPATH/CONFIGS/tmux.conf.local ~/.tmux.conf.local

# nvim
echo -e "\n${BLUE}[*] Installing nvim..${RESET}\n"
wget -q --show-progress https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -O /tmp/nvim-linux-x86_64.tar.gz
sudo tar xzvf /tmp/nvim-linux-x86_64.tar.gz --directory=/opt
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim
sudo rm -f /tmp/nvim-linux-x86_64.tar.gz

# Install kitty terminal
echo -e "\n${BLUE}[*] Installing kitty terminal..${RESET}\n"
cat $RPATH/kitty-installer.sh | sh /dev/stdin

# Clone polybar & picom repositories
mkdir ~/github
git clone --recursive https://github.com/polybar/polybar ~/github/polybar
git clone https://github.com/ibhagwan/picom.git ~/github/picom

# Install polybar
echo -e "\n${BLUE}[*] Installing polybar..${RESET}\n"
cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Install polybar themes
echo -e "\n${BLUE}[*] Installing polybar themes..${RESET}\n"
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git ~/github/polybar-themes
chmod +x ~/github/polybar-themes/setup.sh
cd ~/github/polybar-themes
echo 1 | ./setup.sh

# Install picom
echo -e "\n${BLUE}[*] Installing picom..${RESET}\n"
cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Change timezone
echo -e "\n${BLUE}[*] Installing configurations..${RESET}\n"
sudo timedatectl set-timezone "Europe/Madrid"

mkdir ~/screenshots

# Copy configurations
cp -rv $RPATH/CONFIGS/config/* ~/.config/
cp -rv $RPATH/SCRIPTS/* ~/.config/polybar/forest/scripts/
sudo ln -s ~/.config/polybar/forest/scripts/target.sh /usr/bin/target
sudo ln -s ~/.config/polybar/forest/scripts/screenshot.sh /usr/bin/screenshot

mkdir ~/Wallpapers/
cp -rv $RPATH/WALLPAPERS/* ~/Wallpapers/

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/forest/scripts/target.sh
chmod +x ~/.config/polybar/forest/scripts/screenshot.sh

# Final messages
echo -e "\n${BLUE}[+] Environment deployed, Happy Hacking ;)${RESET}\n"
echo -e "${BLUE}[+] Please reboot the machine (sudo reboot)${RESET}\n"
