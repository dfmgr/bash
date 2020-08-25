#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : python.bash
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : set python version function
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

getpythonver() {
  if [[ "$(python3 -V 2>/dev/null)" =~ "Python 3" ]]; then
    PYTHONVER="python3"
    PIP="pip3"
    export PATH="${PATH}:$(python3 -c 'import site; print(site.USER_BASE)')/bin"
  elif [[ "$(python2 -V 2>/dev/null)" =~ "Python 2" ]]; then
    PYTHONVER="python"
    PIP="pip"
    export PATH="${PATH}:$(python -c 'import site; print(site.USER_BASE)')/bin"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
