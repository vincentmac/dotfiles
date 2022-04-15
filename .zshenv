
#GO Path
export GOPATH=$HOME/go
# export GO111MODULE="on"

# export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR="$VISUAL"

# Google Cloud SDK
#GCLOUD=~/google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
#source '/Users/vincent/google-cloud-sdk/path.zsh.inc'
# The next line enables bash completion for gcloud.
#source '/Users/vincent/google-cloud-sdk/completion.zsh.inc'

# homebrew java sdk
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Add new paths to the PATHDIRS array
PATHDIRS=(
  #/usr/local/git/bin
 # /usr/local/bin
 # /usr/local/lib
 # /usr/local/cassandra/bin
 # /usr/local/mongodb/bin
  /snap/bin
  ${HOME}/.local/bin
  ${HOME}/.dotnet/tools
  /usr/local/go/bin
  ${GOPATH}/bin
  /var/lib/flatpak/exports/bin
  ${HOME}/.cargo/bin
  ${HOME}/Library/Python/2.7/bin
  /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
  /usr/local/Cellar/node/15.2.1/bin
  /usr/local/opt/openjdk/bin
)

for dir in $PATHDIRS; do
  if [ -d $dir ]; then
    paths+=$dir:
  fi
done

export PATH=${paths}${PATH}

# fzf
if [[ `uname` == "Darwin" ]]; then
	export FZF_DEFAULT_COMMAND='fd --type f'
else
	export FZF_DEFAULT_COMMAND='fdfind --type f'
fi
# export FZF_DEFAULT_COMMAND='ag --ignore node_modules -g'
# export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export NVIM_PYTHON_LOG_FILE="${HOME}/nvim_python_log.log"

# Goswagger support
# alias swagger="docker run --rm -it -e GOPATH=$HOME/go:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"


# z setup
#. /Users/vincent/local/bin/z.sh
. /usr/local/bin/z.sh
#  . ${HOME}/.dotfiles/z/z.sh


#function precmd () {
#  z --add "$(pwd -P)"
#}

