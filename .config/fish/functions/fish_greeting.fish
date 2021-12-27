#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __   _____      __          __   ____                 __  _                        __   _____      __                                   __  _                      _____      __
#             _________  ____  / __(_)___ _     _/_/  / __(_)____/ /_       _/_/  / __/_  ______  _____/ /_(_)___  ____  _____     _/_/  / __(_)____/ /_            ____ _________  ___  / /_(_)___  ____ _         / __(_)____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / /_/ / ___/ __ \    _/_/   / /_/ / / / __ \/ ___/ __/ / __ \/ __ \/ ___/   _/_/   / /_/ / ___/ __ \          / __ `/ ___/ _ \/ _ \/ __/ / __ \/ __ `/        / /_/ / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    / __/ (__  ) / / /  _/_/    / __/ /_/ / / / / /__/ /_/ / /_/ / / / (__  )  _/_/    / __/ (__  ) / / /         / /_/ / /  /  __/  __/ /_/ / / / / /_/ /   _    / __/ (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /_/ /_/____/_/ /_/  /_/     /_/  \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  /_/     /_/ /_/____/_/ /_/  ______  \__, /_/   \___/\___/\__/_/_/ /_/\__, /   (_)  /_/ /_/____/_/ /_/
#                                 /____/                                                                                                                 /_____/ /____/                           /____/
#
# Description:  TODO
# Dependencies: this is up to you.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

function fish_greeting
#       bash -c 'fortune -c | cowthink -f $(find /usr/share/cows -type f | shuf -n 1)'
#       bash -c 'fortune -c | ponythink -f $(find /usr/share/ponysay/ponies -type f | shuf -n 1)'
        bash -c 'fortune -c | ponysay --pony'
    
end
