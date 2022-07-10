_fnm() {
  local i cur prev opts cmds
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  cmd=""
  opts=""

  for i in "${COMP_WORDS[@]}"; do
    case "${i}" in
    fnm)
      cmd="fnm"
      ;;

    alias)
      cmd+="__alias"
      ;;
    completions)
      cmd+="__completions"
      ;;
    current)
      cmd+="__current"
      ;;
    default)
      cmd+="__default"
      ;;
    env)
      cmd+="__env"
      ;;
    exec)
      cmd+="__exec"
      ;;
    help)
      cmd+="__help"
      ;;
    install)
      cmd+="__install"
      ;;
    list)
      cmd+="__list"
      ;;
    list-remote)
      cmd+="__list__remote"
      ;;
    ls)
      cmd+="__ls"
      ;;
    ls-remote)
      cmd+="__ls__remote"
      ;;
    uninstall)
      cmd+="__uninstall"
      ;;
    use)
      cmd+="__use"
      ;;
    *) ;;

    esac
  done

  case "${cmd}" in
  fnm)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --multishell-path --log-level --arch   list-remote list install use env completions alias default current exec uninstall help  ls-remote  ls"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --multishell-path)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;

  fnm__alias)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  <to-version> <name> "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__completions)
    opts=" -h -V  --help --version --shell --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --shell)
      COMPREPLY=($(compgen -W "zsh bash fish powershell elvish" -- "${cur}"))
      return 0
      ;;
    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__current)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__default)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  <version> "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__env)
    opts=" -h -V  --multi --use-on-cd --help --version --shell --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --shell)
      COMPREPLY=($(compgen -W "bash zsh fish powershell" -- "${cur}"))
      return 0
      ;;
    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__exec)
    opts=" -h -V  --using-file --help --version --using --node-dist-mirror --fnm-dir --log-level --arch  <arguments>... "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --using)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__help)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__install)
    opts=" -h -V  --lts --help --version --node-dist-mirror --fnm-dir --log-level --arch  <version> "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__list)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__list__remote)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__ls)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__ls__remote)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__uninstall)
    opts=" -h -V  --help --version --node-dist-mirror --fnm-dir --log-level --arch  <version> "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  fnm__use)
    opts=" -h -V  --install-if-missing --help --version --node-dist-mirror --fnm-dir --log-level --arch  <version> "
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in

    --node-dist-mirror)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --fnm-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --log-level)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --arch)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

complete -F _fnm -o bashdefault -o default fnm
