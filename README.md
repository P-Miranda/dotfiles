# dotfiles
Linux dotfiles and other configurations
Setup, installation and usage from [durdn's blog post](https://www.atlassian.com/git/tutorials/dotfiles).

# Initial Setup
1. Create bare git repository: `git init --bare $HOME/.dotfiles`
2. Alias git command for bare repository: `alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. Ignore untracked files by default: `dotgit config --local status.showUntrackedFiles no`
4. Add `dotgit` to `.bashrc`: `echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc; source $HOME/.bashrc`
5. Create a remote repository on Github
6. Add the remote to the local bare repository: `dotgit remote add <remote_name> <repository ssh/url>`
7. Use the `dotgit` repository as a normal git repository.

# Installation on another machine
1. Add the alias to the .bashrc: `echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc; source $HOME/.bashrc`
2. Add the `.dotfiles` folder to `.gitignore`:`echo ".dotfiles" >> .gitignore`
3. Clone the repository: `git clone --bare <repo ssh/url> $HOME/.dotfiles`
4. Checkout the repository contents:`dotgit checkout`
5. If you have conflict, backup the conflicting files to another folder and delete them on the $HOME directory:
```
mkdir -p .config-backup && \
dotgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
6. Re-run the checkout command:`dotgit checkout`
7. Ignore untracked files by default: `dotgit config --local status.showUntrackedFiles no`
8. Use the bare repository as a normal git repo with the `dotgit` alias

# Bashrc Setup
- Bash files included:
	- `.bash_profile`: loaded on login. Sources `~.bashrc`
	- `.bashrc`: loaded on each new terminal. Main file for configurations.
		- Sources `/etc/bashrc`, if exists (system-wide bash configurations)
		- Sources `$HOME/.bash_local`, if exists (local and unsynced configurations)

# Vim Setup
1. Initialize submodules: `dotgit submodule update --init --recursive`
2. Install Vundle Plugins: `vim +PluginInstall +qall`
3. Check '.vim/README.md' for more details
