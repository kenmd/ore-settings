# おまけ: Windows 用スクリプト

# 最初に https://chocolatey.org/install をインストール
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# package インストール
# powershell choco install -y xxx とする必要があるかも
choco install -y git
choco install -y jdk8
choco install -y python3

# sqlcmd
choco install -y sqlserver-cmdlineutils
choco install -y sql-server-management-studio

# IDE
choco install -y vscode
choco install -y intellijidea-community
