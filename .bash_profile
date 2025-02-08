export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

export PATH="$HOME/.local/bin:$CARGO_HOME/bin:~/.local/share/nupm/scripts/:$PATH"

if [[ $(fgconsole 2> /dev/null) == 1 ]]; then
    exec startx -- vt1;
else
    [[ -f ~/.bashrc ]] && . ~/.bashrc
fi

cargo_env="${CARGO_HOME:-$HOME/.cargo}/env"
[[ -f "${cargo_env}" ]] && . "${cargo_env}"

export PICOM_EXTRA_FLAGS="--experimental-backends --animations"
