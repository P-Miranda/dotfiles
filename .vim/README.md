# .vim Repository
Repository for my vim configurations

# Overview
Current contents:
- vimrc: main vim configurations
- bundle/Vundle.vim: submodule with the Vundle Plugin manager
- tmp/: temporary file storage (folder contents ignored)

# Setup
1. Go to your home folder: `cd ~` or `cd /home/$(USER)`
2. Clone the repository: `git clone git@github.com:P-Miranda/.vim.git`
3. Initialize the submodules: `git submodule update --init --recursive`
4. Install plugins: `vim +PluginInstall +qall`
