# Neovim Configuration
Notes about Neovim configuration.

## Current Status
This Neovim configuration tries to use lua configuration following examples from
[LunarVim's Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch)
repository.

## Configuration file location
- Place the files in: `$HOME/.config/nvim`
- `init.lua` is the initial file, which reads all the other specific 
configuration files in `lua/user`.

## Install Neovim from Source
- Clone git repository and checkout `stable` or `nightly` tag:
```
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout nightly
```
- Install dependencies (confirm repository documentation for specific dependencies):
```
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
```
- Compile and prepare installation in `$HOME/opt/neovim`:
```
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/opt/neovim
make install
```
- Note: before installing you can check the neovim build with:
```
VINRUNTIME=runtime ./build/bin/nvim
```
- Add `$HOME/opt/neovim/bin` to path in `~/.bashrc`:
```
PATH=$HOME/opt/neovim/bin:$PATH
```

## Clean or Uninstall
- Remove build directory from neovim clone:
```
rm -r build
# or
make distclean
```
- Remove directories:
```
rm -rf $HOME/opt/neovim
rm -rf .local/share/nvim
```
