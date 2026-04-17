# Neovim Config

My personal neovim config using [lazy.nvim](https://lazy.folke.io/) plugin manager

## Requirements

- Neovim 0.12+
- git 2.52+
- Nerd Font
- Luarocks

## Install

```sh
git clone git@github.com:YOUR_USERNAME/nvim.git ~/.config/nvim
nvim
```

## Tree

```sh
.
├── init.lua         <-- lua reads this file firstly 
├── lazy-lock.json   <-- plugin versions, auto handled by lazy.nvim
├── lua
│   ├── config
│   │   └── lazy.lua <-- bootstrap the install of lazy.nvim (if missing) and loads plugins
│   └── plugins
│       ├── plugin_1.lua
│       ├── plugin_2.lua
│       └── ...
└── README.md
```

## Modify Vim (not for nvim, optional)

```sh
nvim ~/.vimrc
```

```sh
set relativenumber
set cursorline
highlight LineNrAbove ctermfg=Blue cterm=bold guifg=#51B3EC gui=bold
highlight CursorLineNr ctermfg=Black cterm=bold guifg=#000000 gui=bold
highlight LineNrBelow ctermfg=Magenta cterm=bold guifg=#FB508F gui=bold

" Indentation & tabs
set shiftwidth=2      " 2 spaces for autoindent
set tabstop=2         " 2 spaces for \t
set softtabstop=2     " 2 spaces when you hit tab
set expandtab         " spaces instead of tab character
```
