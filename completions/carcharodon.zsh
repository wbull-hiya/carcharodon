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
        'numbers:List available test numbers'
        'help:Show help information'
    )

    local -a global_opts
    global_opts=(
        '--json[Output raw JSON]'
        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
        '(-h --help)'{-h,--help}'[Show help]'
        '(-v --version)'{-v,--version}'[Show version]'
    )

    local -a levels
    levels=(ok uncertain spam fraud)

    local -a shorthands
    shorthands=(
        'ok:Random OK number'
        'uncertain:Random uncertain number'
        'spam:Random spam number'
        'fraud:Random fraud number'
        'spam\:telemarketer:Spam telemarketer'
        'spam\:robocaller:Spam robocaller'
        'fraud\:tax-scam:Tax scam'
        'fraud\:extortion:Extortion scam'
        'fraud\:tech-support-scam:Tech support scam'
    )

    local -a categories
    categories=(telemarketer robocaller survey nonprofit extortion 'tax-scam' 'tech-support-scam' 'scam-or-fraud')

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
                        '(-f --from)'{-f,--from}'[Caller ID or shorthand]:from number:((${(kv)shorthands}))' \
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
                numbers)
                    _arguments \
                        '(-l --level)'{-l,--level}'[Filter by level]:level:(${levels})' \
                        '(-c --category)'{-c,--category}'[Filter by category]:category:(${categories})' \
                        '(-r --region)'{-r,--region}'[Filter by region]:region:(us uk)' \
                        '--json[Output raw JSON]' \
                        '(-q --quiet)'{-q,--quiet}'[Minimal output]'
                    ;;
            esac
            ;;
    esac
}

_carcharodon "$@"
