#
# Function wrapper to docker-machine that adds a use subcommand.
#
# The use subcommand runs `eval "$(docker-machine env [args])"`, which is a lot
# less typing.
#
# To enable:
#  1a. Copy this file somewhere and source it in your .bashrc
#      source /some/where/docker-machine-wrapper.bash
#  1b. Alternatively, just copy this file into into /etc/bash_completion.d
#
# Configuration:
#
# DOCKER_MACHINE_WRAPPED
#   When set to a value other than true, this will disable the alias wrapper
#   alias for docker-machine. This is useful if you don't want the wrapper,
#   but it is installed by default by your installation.
#

: ${DOCKER_MACHINE_WRAPPED:=true}

__docker_machine_wrapper () {
    if [[ "$1" == use ]]; then
        # Special use wrapper
        shift 1
        case "$1" in
            -h|--help|"")
                cat <<EOF
Usage: docker-machine use [OPTIONS] [arg...]

Evaluate the commands to set up the environment for the Docker client

Description:
   Argument is a machine name.

Options:

   --swarm	Display the Swarm config instead of the Docker daemon
   --unset, -u	Unset variables instead of setting them

EOF
                ;;
            *)
                eval "$(docker-machine env "$@")"
                echo "Active machine: ${DOCKER_MACHINE_NAME}"
                ;;
        esac
    else
        # Just call the actual docker-machine app
        command docker-machine "$@"
    fi
}

if [[ ${DOCKER_MACHINE_WRAPPED} = true ]]; then
    alias docker-machine=__docker_machine_wrapper
fi

#
# bash prompt support for docker-machine
#
# This script allows you to see the active machine in your bash prompt.
#
# To enable:
#  1a. Copy this file somewhere and source it in your .bashrc
#      source /some/where/docker-machine-prompt.bash
#  1b. Alternatively, just copy this file into into /etc/bash_completion.d
#  2. Change your PS1 to call __docker-machine-ps1 as command-substitution
#     PS1='[\u@\h \W$(__docker_machine_ps1 " [%s]")]\$ '
#
# Configuration:
#
# DOCKER_MACHINE_PS1_SHOWSTATUS
#   When set, the machine status is indicated in the prompt. This can be slow,
#   so use with care.
#

__docker_machine_ps1 () {
    local format=${1:- [%s]}
    if test ${DOCKER_MACHINE_NAME}; then
        local status
        if test ${DOCKER_MACHINE_PS1_SHOWSTATUS:-false} = true; then
            status=$(docker-machine status ${DOCKER_MACHINE_NAME})
            case ${status} in
                Running)
                    status=' R'
                    ;;
                Stopping)
                    status=' R->S'
                    ;;
                Starting)
                    status=' S->R'
                    ;;
                Error|Timeout)
                    status=' E'
                    ;;
                *)
                    # Just consider everything elase as 'stopped'
                    status=' S'
                    ;;
            esac
        fi
        printf -- "${format}" "${DOCKER_MACHINE_NAME}${status}"
    fi
}
#
# bash completion file for docker-machine commands
#
# This script provides completion of:
#  - commands and their options
#  - machine names
#  - filepaths
#
# To enable the completions either:
#  - place this file in /etc/bash_completion.d
#  or
#  - copy this file to e.g. ~/.docker-machine-completion.sh and add the line
#    below to your .bashrc after bash completion features are loaded
#    . ~/.docker-machine-completion.sh
#

_docker_machine_active() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=()
    fi
}

_docker_machine_config() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--swarm --help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_create() {
    # cheating, b/c there are approximately one zillion options to create
    COMPREPLY=($(compgen -W "$(docker-machine create --help | grep '^   -' | sed 's/^   //; s/[^a-z0-9-].*$//')" -- "${cur}"))
}

_docker_machine_env() {
    case "${prev}" in
        --shell)
            # What are the options for --shell?
            COMPREPLY=()
            ;;
        *)
            if [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "--swarm --shell --unset --no-proxy --help" -- "${cur}"))
            else
                COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
            fi
    esac
}

# See docker-machine-wrapper.bash for the use command
_docker_machine_use() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--swarm --unset --help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_inspect() {
    case "${prev}" in
        -f|--format)
            COMPREPLY=()
            ;;
        *)
            if [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "--format --help" -- "${cur}"))
            else
                COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
            fi
            ;;
    esac
}

_docker_machine_ip() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_kill() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_ls() {
    case "${prev}" in
        --filter)
            COMPREPLY=()
            ;;
        *)
            COMPREPLY=($(compgen -W "--quiet --filter --format --timeout --help" -- "${cur}"))
            ;;
    esac
}

_docker_machine_regenerate_certs() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help --force" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_restart() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_rm() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help --force -y" -- "${cur}"))
    else
        # For rm, it's best to be explicit
        COMPREPLY=()
    fi
}

_docker_machine_ssh() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_scp() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help --recursive" -- "${cur}"))
    else
        _filedir
        # It would be really nice to ssh to the machine and ls to complete
        # remote files.
        COMPREPLY=($(compgen -W "$(docker-machine ls -q | sed 's/$/:/')" -- "${cur}") "${COMPREPLY[@]}")
    fi
}

_docker_machine_start() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_status() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_stop() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_upgrade() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_url() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_version() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "$(docker-machine ls -q)" -- "${cur}"))
    fi
}

_docker_machine_help() {
    if [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "--help" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "${commands[*]}" -- "${cur}"))
    fi
}

_docker_machine_docker_machine() {
    if [[ " ${wants_file[*]} " =~ " ${prev} " ]]; then
        _filedir
    elif [[ " ${wants_dir[*]} " =~ " ${prev} " ]]; then
        _filedir -d
    elif [[ "${cur}" == -* ]]; then
        COMPREPLY=($(compgen -W "${flags[*]} ${wants_dir[*]} ${wants_file[*]}" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "${commands[*]}" -- "${cur}"))
    fi
}

_docker_machine() {
    COMPREPLY=()
    local commands=(active config create env inspect ip kill ls regenerate-certs restart rm ssh scp start status stop upgrade url version help)

    local flags=(--debug --native-ssh --github-api-token --bugsnag-api-token --help --version)
    local wants_dir=(--storage-path)
    local wants_file=(--tls-ca-cert --tls-ca-key --tls-client-cert --tls-client-key)

    # Add the use subcommand, if we have an alias loaded
    if [[ ${DOCKER_MACHINE_WRAPPED} = true ]]; then
        commands=("${commands[@]}" use)
    fi

    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword
    local i
    local command=docker-machine

    for (( i=1; i < ${cword}; ++i)); do
        local word=${words[i]}
        if [[ " ${wants_file[*]} ${wants_dir[*]} " =~ " ${word} " ]]; then
            # skip the next option
            (( ++i ))
        elif [[ " ${commands[*]} " =~ " ${word} " ]]; then
            command=${word}
        fi
    done

    local completion_func=_docker_machine_"${command//-/_}"
    if declare -F "${completion_func}" > /dev/null; then
        ${completion_func}
    fi

    return 0
}

complete -F _docker_machine docker-machine
