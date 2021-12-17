function fish_greeting
#       bash -c 'fortune -c | cowthink -f $(find /usr/share/cows -type f | shuf -n 1)'
#       bash -c 'fortune -c | ponythink -f $(find /usr/share/ponysay/ponies -type f | shuf -n 1)'
        bash -c 'fortune -c | ponysay --pony'
    
end
