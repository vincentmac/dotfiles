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


