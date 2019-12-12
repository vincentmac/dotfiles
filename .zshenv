
#GO Path
#export GOPATH=/usr/local/lib/go/
export GOPATH=$HOME/go

# Google Cloud SDK
#GCLOUD=~/google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
#source '/Users/vincent/google-cloud-sdk/path.zsh.inc'
# The next line enables bash completion for gcloud.
#source '/Users/vincent/google-cloud-sdk/completion.zsh.inc'


# Add new paths to the PATHDIRS array
PATHDIRS=(
  #/usr/local/git/bin
 # /usr/local/bin
 # /usr/local/lib
 # /usr/local/cassandra/bin
 # /usr/local/mongodb/bin
  ${HOME}/.local/bin
  ${HOME}/.dotnet/tools
  /usr/local/go/bin
  ${GOPATH}/bin
  /var/lib/flatpak/exports/bin
)

for dir in $PATHDIRS; do
  if [ -d $dir ]; then
    paths+=$dir:
  fi
done

export PATH=${paths}${PATH}

# export FZF_DEFAULT_COMMAND='ag --ignore node_modules -g'

#alias goapp=${GCLOUD}/platform/google_appengine/goapp

# Node harmony support
# alias node='node --harmony'

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# rbenv shim
#eval "$(rbenv init -)"


# z setup
#. /Users/vincent/local/bin/z.sh
. /usr/local/bin/z.sh
#  . ${HOME}/.dotfiles/z/z.sh


#function precmd () {
#  z --add "$(pwd -P)"
#}

