--*
--*                  _    __ _ _
--*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
--*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
--*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
--*  |___/
--*          MAINTAINERS:
--*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
--*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
--*

vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


vim.cmd([[
  highlight RedundantSpaces ctermbg=red guibg=red
  match RedundantSpaces /\s\+$/
]])

vim.cmd([[
  autocmd TermOpen * startinsert
]])
