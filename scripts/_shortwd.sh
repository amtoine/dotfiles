#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                 __               __               __              __
#        _______________(_)___  / /______     _/_/           _____/ /_  ____  _____/ /__      ______/ /        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / ___/ __ \/ __ \/ ___/ __/ | /| / / __  /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             (__  ) / / / /_/ / /  / /_ | |/ |/ / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   /____/_/ /_/\____/_/   \__/ |__/|__/\__,_/   (_)  /____/_/ /_/
#                     /_/                       /_____/
#
# Description:  gives a short directory in prompt, not to fill the entire line when inside nested directories.
#               For instance, let us say that the maximum number of directories changes allowed is 3, i.e. one
#               can use 3 times cd to go deeper, then
#                    if one is in ~/dir1/dir2/dir3,           then the prompt will give ~/dir1/dir2/dir3
#                    if one is in ~/dir1/dir2/dir3/dir4,      then the prompt will give ~/.../dir3/dir4
#                    if one is in /tmp/dir1/dir2/dir3,        then the prompt will give /tmp/dir1/dir2/dir3
#                    if one is in /tmp/dir1/dir2/dir3/dir4,   then the prompt will give /tmp/.../dir3/dir4
#               thus, there is allways one field more than the maximum depth allowed.
#
#               Args
#               ----
#               max_cds: interger, positional, optional, defaults to 3
#                 the maximum number of cd allowed to go deeper, from $HOME or from /dir/ with dir being
#                 tmp, var, bin, ...
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# get the max number of cd allowed.
# defaults to 3 if no argument of too many arguments.
if [[ $# == 1 ]]; then
    max_cds=$1
else
    max_cds=3
fi
# add two more extra directories, one for the first one in path and one for the trailing empty directory given by awk.
limit=$(($max_cds + 2))

# compute the new directory and the number of directories in the whole path.
new_dir="${PWD/#$HOME/~}"
num_dirs=$(echo -n $new_dir | awk -F '/' '{print NF}')

# two cases...
if [[ $new_dir =~ ^$HOME* ]]; then
    # when in /home/user/, '/home/user/' counts as one directory depth as it is printed as '~' in the prompt.
    # so we need to add one to the limit not to take /user/ as a real directory chosen by the user.
    limit=$(($limit + 1))
    if [ $num_dirs -gt $limit ]; then
        # remove directories if prompt too long.
        new_dir="~$(echo -n $new_dir | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')"
    else
        # anyway replace '/home/user/' by '~'.
        new_dir=$(echo $new_dir | sed -e "s|$HOME|~|g")
    fi
else
    # no extra directory.
    if [ $num_dirs -gt $limit ]; then
        # get the name of the directory, e.g. tmp for /tmp, and add the directories with extra ones removed.
        dir=$(echo -n $new_dir | cut -d/ -f 2);
        new_dir="/$dir$(echo -n $new_dir | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')"
    fi
fi
# finally print the prompt.
echo -n $new_dir
