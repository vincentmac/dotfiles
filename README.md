# Dotfiles

See https://www.atlassian.com/git/tutorials/dotfiles

## Starting from scratch
```
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```

### Adding files to track:
```
config status
config add .vim/vimrc
config commit -m "Add vimrc"
config add .zshenv .zshrc
config commit -m "Add zsh"
config push
```

### Install dotfiles onto a new system (or migrate to this setup)
If you already store your configuration/dotfiles in a Git repository, on a new system you can migrate to this setup with the following steps:

-Prior to the installation make sure you have committed the alias to your `.bashrc` or `.zsh`:
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
-And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:
```
echo ".dotfiles" >> .gitignore
```
-Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:
```
git clone --bare <git-repo-url> $HOME/.dotfiles
```
-Define the alias in the current shell scope:
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
-Checkout the actual content from the bare repository to your $HOME:
```
config checkout
```
-The step above might fail with a message like:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
-This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
-Re-run the check out if you had problems:
```
config checkout
```
-Set the flag `showUntrackedFiles` to no on this specific (local) repository:
```
config config --local status.showUntrackedFiles no
```
You're done, from now on you can now type config commands to add and update your dotfiles:
```
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```
