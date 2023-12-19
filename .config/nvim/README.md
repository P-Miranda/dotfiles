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
sudo apt install ninja-build gettext cmake unzip curl
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

## Install from Tarball
- Create and move to folder:
```
mkdir -p ~/opt
cd ~/opt
```
- Download and extract tarball (nightly link):
```
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzvf nvim-linux64.gz
```
- Add to `$PATH` in `~/.bashrc`:
```Bash
PATH=$HOME/opt/nvim-linux64/bin:$PATH
```

- **Note**: to uninstall just remove the files in `~/opt/nvim-linux64*`:
```
rm -rf ~/opt/nvim-linux64*
rm -rf $HOME/.local/share/nvim
```

## Setup external dependencies
- Quick guide:
```
sudo apt update;
sudo install xsel ripgrep fd-find python3-venv
```
- Overall check with: `:checkhealth`
- Clipboard (see `:help clipboard`): install `xsel` (or similar)
- Ripgrep for telescope (see `:checkhealth Telescope`)
- Python3-venv for Python LSP

- Install Node.js (for Copilot)

### LSP Setups (Old)
Note: LSP Setups are managed via Mason plugins.
#### Sumneko Lua (Lua)
- Follow instructions from [Sumneko Lua Repository](https://github.com/sumneko/lua-language-server/wiki/Build-and-Run)

- Add to $PATH:
```bash
export PATH=$HOME/src_repos/lua-language-server/bin:$PATH
```
#### Clangd LSP Server (C/C++)

1. [Instructions Page](https://clangd.llvm.org/installation.html)

2. [Download Standalone .zip Relase](https://github.com/clangd/clangd/releases/tag/13.0.0)

3. Unzip folder and copy to ~/opt/:
```
cp -r ~/Downloads/clangd_13.0.0 ~/opt/
```

4. Add to path:
```
export PATH=$HOME/opt/clangd_13.0.0/bin:$PATH
```

5. Install [Bear](https://github.com/rizsotto/Bear)
- I could not install from source (some problems with dependencies)
- So I installed from the package manager some older version

6. Generate `compile_commands.json` with:` bear <make command>`
