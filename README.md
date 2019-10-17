# 俺の設定 - Ore Settings

* My settings for bash, vim and brew


## How to use

* 引越し後、まず Homebrew をインストール

```bash
# install Command Line Tools (CLT) for Xcode
xcode-select --install

# install command from https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# for Xcode user?
# xcodebuild -license accept
```

* clone してリンク作成

```bash
# Documents に github というディレクトリを作るのは my convention
cd ~/Documents/github/kenmd/
git clone https://github.com/kenmd/ore-settings.git

# these commands will create link to home directory
cd $HOME

ln -s ~/Documents/github/kenmd/ore-settings/.vimrc

# Use zsh as the default shell on your Mac
# https://support.apple.com/en-us/HT208050
ln -s ~/Documents/github/kenmd/ore-settings/.zshrc
ln -s ~/Documents/github/kenmd/ore-settings/.zprofile

ln -s ~/Documents/github/kenmd/ore-settings/bin
```


## How to move brew packages

* 必要なら `adoptopenjdk` の version を修正 (デフォルトは最新版)
  - https://github.com/AdoptOpenJDK/homebrew-openjdk
* fail 時は System Preference > Security & Privacy > General
  - Allow apps downloaded from で adoptopenjdk の実行を許可
* `java -version` で動作確認して、install を再実行

```bash
# show installs/upgrades
brew bundle check --verbose

# install all packages
brew bundle install --verbose

# (以下、既にインストール済みのものがある場合)

# Brewfile を再作成して差分を確認
brew bundle dump

# uninstall packages not in Brewfile
brew bundle cleanup
```


## Initial setup commands

* 初期設定コマンドの例 (必要なもののみ選択してコピペ実行)
* `brew info xxx` により、インストール後にすべき設定を確認できる
  - (例) `brew info git` `brew info zsh-completion`

```bash
git config --global fetch.prune true
git config --global user.name "Foo Bar"
git config --global user.email "foo.bar@example.com"

# initialize zcompdump
rm -f ~/.zcompdump; compinit

pyenv install --list | grep 3.7
pyenv install 3.7.4
pyenv global 3.7.4

pyenv install --list | grep 2.7
pyenv install 2.7.16

pip list --outdated
pip install --upgrade pip setuptools

ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

# jenv (https://github.com/jenv/jenv)
jenv enable-plugin export
jenv add $(/usr/libexec/java_home -v 1.8)
jenv global 1.8
jenv versions
jenv doctor
/usr/libexec/java_home -V

# Node
nodenv init
eval "$(nodenv init -)"

nodenv install -l | grep 10.16
nodenv install 10.16.3
nodenv global 10.16.3
```


## Optional packages

* DB

```bash
brew install redis

brew install postgres
# brew services start postgresql OR pg_ctl -D /usr/local/var/postgres start

brew cask install psequel

# SQLCMD
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
export ACCEPT_EULA=y
brew install msodbcsql mssql-tools

brew install elasticsearch
```

* languages

```bash
brew install scala
brew install sbt

brew install go

brew install rbenv
rbenv init

rbenv install -l | grep 2.6
rbenv install 2.6.5
rbenv versions
rbenv global 2.6.5
ruby -v
brew install rbenv-communal-gems
```

* misc

```bash
# for this error: zipimport.ZipImportError: can't decompress data; zlib not available
brew install zlib

pip install ptvsd

brew cask install virtualbox
brew cask install vagrant

# Bash script to convert from HTML entities to characters
# https://stackoverflow.com/questions/5929492
brew install recode

brew install imagemagick

# Python 3.5.1でimport tkinterできない時
# https://qiita.com/hokkun_dayo/items/223b1125b814621a0c0e
brew install tcl-tk

brew install ipcalc

brew cask install firefox
```

* update/upgrade

```bash
# update/upgrade brew
brew update && brew upgrade
```


## Reference

* brew tap で入れる Homebrew 外部コマンド
  - https://qiita.com/tearoom6/items/1abf24ca6d872e6579b0
* brew bundleでMacのアプリをまとめてインストール・管理
  - https://qiita.com/vochicong/items/f20afc89a6847cd58f0f
