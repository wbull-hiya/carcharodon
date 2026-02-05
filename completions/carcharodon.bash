# Bash completion for carcharodon
# Add to ~/.bashrc: source /path/to/carcharodon/completions/carcharodon.bash

_carcharodon() {
    local cur prev words cword
    _init_completion || return

    local commands="call status cancel timestamps numbers help"
    local global_opts="--json --quiet -q --help -h --version -v"
    local levels="ok uncertain spam fraud"
    local trunks="flowroute telnyx bandwidth"
    local shorthands="ok uncertain spam fraud spam:telemarketer spam:robocaller spam:survey fraud:tax-scam fraud:extortion fraud:tech-support-scam"

    case "${prev}" in
        carcharodon)
            COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
            return 0
            ;;
        call)
            COMPREPLY=($(compgen -W "-t --to -f --from --trunk --cancel-after --wait --json --quiet -q" -- "${cur}"))
            return 0
            ;;
        status|cancel|timestamps)
            COMPREPLY=($(compgen -W "-i --id --json --quiet -q" -- "${cur}"))
            return 0
            ;;
        numbers)
            COMPREPLY=($(compgen -W "-l --level -c --category -r --region --json --quiet -q" -- "${cur}"))
            return 0
            ;;
        -t|--to)
            # Phone number - no completion
            return 0
            ;;
        -f|--from)
            # Phone number or shorthand
            COMPREPLY=($(compgen -W "${shorthands}" -- "${cur}"))
            return 0
            ;;
        -i|--id)
            # Call ID - no completion
            return 0
            ;;
        -l|--level)
            COMPREPLY=($(compgen -W "${levels}" -- "${cur}"))
            return 0
            ;;
        --trunk)
            COMPREPLY=($(compgen -W "${trunks}" -- "${cur}"))
            return 0
            ;;
        -c|--category)
            COMPREPLY=($(compgen -W "telemarketer robocaller survey nonprofit extortion tax-scam tech-support-scam scam-or-fraud" -- "${cur}"))
            return 0
            ;;
        -r|--region)
            COMPREPLY=($(compgen -W "us uk" -- "${cur}"))
            return 0
            ;;
        --cancel-after)
            COMPREPLY=($(compgen -W "10000 20000 30000 35000 60000" -- "${cur}"))
            return 0
            ;;
    esac

    # Handle options based on the command
    local cmd=""
    for ((i=1; i < cword; i++)); do
        case "${words[i]}" in
            call|status|cancel|timestamps|numbers)
                cmd="${words[i]}"
                break
                ;;
        esac
    done

    case "${cmd}" in
        call)
            COMPREPLY=($(compgen -W "-t --to -f --from --trunk --cancel-after --wait --json --quiet -q" -- "${cur}"))
            ;;
        status|cancel|timestamps)
            COMPREPLY=($(compgen -W "-i --id --json --quiet -q" -- "${cur}"))
            ;;
        numbers)
            COMPREPLY=($(compgen -W "-l --level -c --category -r --region --json --quiet -q" -- "${cur}"))
            ;;
        *)
            COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
            ;;
    esac
}

complete -F _carcharodon carcharodon
