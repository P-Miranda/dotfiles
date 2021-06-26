# dotfiles
Linux dotfiles and other configurations
Setup, installation and usage from [durdn's blog post](https://www.atlassian.com/git/tutorials/dotfiles)

# Initial Setup
1. Create bare git repository: `git init --bare $HOME/.dotfiles`
2. Alias git command for bare repository: `alias dotfiles_config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. Ignore untracked files by default: `dotfiles_config config --local status.showUntrackedFiles no`
4. Add `dotfiles_config` to `.bashrc`: `echo "alias dotfiles_config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`
5. Create a remote repository on Github
6. Add the remote to the local bare repository: `dotfiles_config remote add <remote_name> <repository ssh/url>`
7. Use the `dotfiles_config` repository as a normal git repository.

# Installation on another machine
1. Add the alias to the .bashrc: `echo "alias dotfiles_config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`
2. Add the `.dotfiles` folder to `.gitignore`:`echo ".dotfiles" >> .gitignore`
3. Clone the repository: `git clone --bare <repo ssh/url> $HOME/.dotfiles`
4. Checkout the repository contents:`dotfiles_config checkout`
5. If you have conflict, backup the conflicting files to another folder and delete them on the $HOME directory:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
6. Re-run the checkout command:`dotfiles_config checkout`
7. Ignore untracked files by default: `dotfiles_config config --local status.showUntrackedFiles no`
8. Use the bare repository as a normal git repo with the `dotfiles_config` alias
