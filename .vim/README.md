## Install vim. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
- install the dependencies in [vim](https://github.com/a2n-s/dotfiles/tree/main/#dependencies-for-vim-toc).
- install the `vim` command.
- copy [`.vimrc`] inside your `~/` directory.


## Dependencies for vim. [[toc](https://github.com/a2n-s/dotfiles/tree/main/#table-of-content)]
- make sure to either run `vim` once with the `.vimrc` file installed or issue `mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/color ~/.vim/plugged`.
- a plugin manager: I use `vim-plug` which can be installed with `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
- the `molokai` colorscheme -> can be installed with `cd ~/.vim/colors; curl -o molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim`.
