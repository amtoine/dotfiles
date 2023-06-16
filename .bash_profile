export XDG_DATA_HOME="$HOME/.local/share"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

export PATH="$CARGO_HOME/bin:$PATH"

if [[ $(fgconsole 2> /dev/null) == 1 ]]; then
    exec startx -- vt1;
else
    [[ -f ~/.bashrc ]] && . ~/.bashrc
fi

cargo_env="${CARGO_HOME:-$HOME/.cargo}/env"
[[ -f "${cargo_env}" ]] && . "${cargo_env}"
