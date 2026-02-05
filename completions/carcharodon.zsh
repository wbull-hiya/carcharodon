#compdef carcharodon

# Zsh completion for carcharodon
# Add to fpath and run: autoload -Uz compinit && compinit

_carcharodon() {
    local -a commands
    commands=(
        'call:Place a spoofed call'
        'status:Get call status'
        'cancel:Cancel an active call'
        'timestamps:Get SIP timing information'
        'help:Show help information'
    )

    local -a global_opts
    global_opts=(
        '--json[Output raw JSON]'
        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
        '(-h --help)'{-h,--help}'[Show help]'
        '(-v --version)'{-v,--version}'[Show version]'
    )

    _arguments -C \
        '1:command:->command' \
        '*::arg:->args'

    case "$state" in
        command)
            _describe -t commands 'carcharodon commands' commands
            _describe -t options 'options' global_opts
            ;;
        args)
            case "$words[1]" in
                call)
                    _arguments \
                        '(-t --to)'{-t,--to}'[Destination phone number]:phone number:' \
                        '(-f --from)'{-f,--from}'[Caller ID to display]:phone number:' \
                        '--cancel-after[Auto-cancel timeout in ms]:milliseconds:(10000 20000 30000 35000 60000)' \
                        '--wait[Wait for call to complete]' \
                        '--json[Output raw JSON]' \
                        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
                    ;;
                status)
                    _arguments \
                        '(-i --id)'{-i,--id}'[Call ID]:call id:' \
                        '--json[Output raw JSON]' \
                        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
                    ;;
                cancel)
                    _arguments \
                        '(-i --id)'{-i,--id}'[Call ID]:call id:' \
                        '--json[Output raw JSON]' \
                        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
                    ;;
                timestamps)
                    _arguments \
                        '(-i --id)'{-i,--id}'[Call ID]:call id:' \
                        '--json[Output raw JSON]' \
                        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
                    ;;
            esac
            ;;
    esac
}

_carcharodon "$@"
