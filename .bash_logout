# when leaving the console clear the screen to increase privacy

echo "$HOME/.bash_logout"
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
