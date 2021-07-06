# .vim Configuration
My vim configurations

# Overview
Current contents:
- vimrc: main vim configurations
- bundle/Vundle.vim: submodule with the Vundle Plugin manager
- tmp/: temporary file storage (folder contents ignored)

# Setup
Check top level ``README.md`

# Add Vundle Plugin Manager
1. Add Vundle submodule: `git submodule add git@github.com:VundleVim/Vundle.vim .vim/bundle/Vundle.vim`


# Plugin Installation
1. Add a line to `.vim/vimrc`:
	```
	Plugin 'author/plugin-repo-name'
	```
2. Run the following in Vim:
	```
	:source % " reload vimrc configuration
	:PluginInstall " try to install all plugins
	```

# Current Plugins
- Vundle: plugin manager
- Gruvbox: colorscheme
- Commentary: comment stuff out
