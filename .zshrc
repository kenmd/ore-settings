
export HISTSIZE=50000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:exit'
export PROMPT_COMMAND="history -a"

alias ls='ls -h -G -F'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias tree='tree -L 3 --filelimit 8'
alias treedir='tree -d'

alias gimp="/Applications/GIMP-2.10.app/Contents/MacOS/gimp"

export PATH="~/bin:$PATH"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export CDPATH=.:~/Documents/github

export LANG=ja_JP.UTF-8

gointo() { docker exec -ti $1 bash; }

function cd {
    builtin cd "$@"
    if [ -f "Pipfile" ] ; then
        pipenv shell
    fi
}

# complete:13: command not found: compdef
# https://apple.stackexchange.com/questions/296477
autoload -Uz compinit
compinit

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-prompt.sh

source /usr/local/etc/bash_completion.d/tig-completion.bash

# https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
# https://qiita.com/koyopro/items/3fce94537df2be6247a3
if type __git_ps1 > /dev/null 2>&1 ; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=true
  precmd () { __git_ps1 "%m" ":%~$ " "|%s" }
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# for pip install --user hoge
USER_BASE_PATH=$(python -m site --user-base)
export PATH="$USER_BASE_PATH/bin:$PATH"

# pipenv
export PIPENV_VENV_IN_PROJECT=true
eval "$(pipenv --completion)"

eval "$(jenv init -)"

eval "$(nodenv init -)"
export PATH=./node_modules/.bin:$PATH

# force use Python 2.7
export CLOUDSDK_PYTHON=~/.pyenv/versions/2.7.16/bin/python

# brew cask install google-cloud-sdk
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# mssql-cli Disable telemetry collection
# export MSSQL_CLI_TELEMETRY_OPTOUT=True
