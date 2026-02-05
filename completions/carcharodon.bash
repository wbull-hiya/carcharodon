# Bash completion for carcharodon
# Add to ~/.bashrc: source /path/to/carcharodon/completions/carcharodon.bash

_carcharodon() {
    local cur prev words cword
    _init_completion || return

    local commands="call status cancel timestamps help"
    local global_opts="--json --quiet -q --help -h --version -v"

    case "${prev}" in
        carcharodon)
            COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
            return 0
            ;;
        call)
            COMPREPLY=($(compgen -W "-t --to -f --from --cancel-after --wait --json --quiet -q" -- "${cur}"))
            return 0
            ;;
        status|cancel|timestamps)
            COMPREPLY=($(compgen -W "-i --id --json --quiet -q" -- "${cur}"))
            return 0
            ;;
        -t|--to|-f|--from)
            # Phone number - no completion
            return 0
            ;;
        -i|--id)
            # Call ID - no completion
            return 0
            ;;
        --cancel-after)
            # Timeout value - suggest common values
            COMPREPLY=($(compgen -W "10000 20000 30000 35000 60000" -- "${cur}"))
            return 0
            ;;
    esac

    # Handle options based on the command
    local cmd=""
    for ((i=1; i < cword; i++)); do
        case "${words[i]}" in
            call|status|cancel|timestamps)
                cmd="${words[i]}"
                break
                ;;
        esac
    done

    case "${cmd}" in
        call)
            COMPREPLY=($(compgen -W "-t --to -f --from --cancel-after --wait --json --quiet -q" -- "${cur}"))
            ;;
        status|cancel|timestamps)
            COMPREPLY=($(compgen -W "-i --id --json --quiet -q" -- "${cur}"))
            ;;
        *)
            COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
            ;;
    esac
}

complete -F _carcharodon carcharodon
