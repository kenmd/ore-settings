#!/bin/bash -eux

# from https://gist.github.com/krispayne/a4af5f4bb33a88eacf76

ps ax | grep -w 'symantec.mes.systemextension\|SymDaemon\|SymSharedSettingsd\|SymUIAgent' | awk '{print $1}' | xargs kill -9
