# dotfiles

Personal dotfiles for setting up a new machine and keeping configurations in sync.

These configurations are made to work with `zsh` as a shell using `oh-my-zsh` as a the main configuration tool.

## Structure

The dotfiles are structured in the following way:

- configs: a set of configuration files which are symlinked to the the home folder.
- scripts: a set of shell (.zsh in this case) files which are sourced when the shell is starting. It should mainly contain aliases and functions that can be used by the user.
- installer.sh, sys_packages.sh, utils.sh, mac_defaults.sh: scripts used to perform setup operations.
- iterm-prof.json: iterm configuration, the easiest is to import it manually into iterm2.

```
.
├── configs
│   ├── .gitconfig
│   ├── .gitignore_global
│   ├── .p10k.zsh
│   ├── .python-setup.zsh
│   ├── .rsync.excludes
│   ├── .tmux.conf
│   ├── .tmux_env
│   ├── .vimrc
│   ├── .zshenv
│   ├── .zshrc
│   └── ipython_config.py
├── scripts
│   ├── alias.zsh
│   ├── func.zsh
│   ├── history.zsh
│   └── keybindings.zsh
├── installer.sh
├── iterm-prof.json
├── mac_default.sh
├── sys_packages.sh
└── utils.zsh
```

## Install

To run the installer simply use the following command.

```
cd $DOTFILES
./installer.sh
```

This might break if some packages are not present. To install the required packages have a look at the `sys_packages.sh` script which has a set of packages that can be installed separately.

```
cd $DOTFILES
./sys_packages.sh install --cli
```

Other install options are: `python`, `cliopt`, `others`.