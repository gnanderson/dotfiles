# command mode
set -o vi

## Amazon AWS CLi tool
#export EC2_HOME="/home/ganderson/bin/ec2"
#export AWS_RDS_HOME="/home/ganderson/bin/rdsc"
#export EC2_CERT=""
#export EC2_PRIVATE_KEY=""

# Chromium
export XDG_CACHE_HOME=/tmp

# Assembla
export ASSEMBLA_SPACE="GANT AB"

# Go
PATH=~/go/bin:/usr/local/go/bin:$PATH
export GOPATH=~/go

# CD path
#export CDPATH=$GOPATH/src:~/Sites

test -s ~/.alias && . ~/.alias || true

# amazon tools path
#export PATH=$PATH:$EC2_HOME/bin:$AWS_RDS_HOME/bin

# LFS settings
export LFS=/mnt/lfs

# Homeshick
source "$HOME/.func/docker.sh"

# Aliases
alias colours='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done'
alias tmux='tmux -2'
alias scp='scp -p'
alias ls='ls -G'
alias la='ls -G -la'
alias gvg='cd ~/Sites/shop-gant/infrastructure && vagrant'
alias dmach='docker-machine'
alias dcc='docker rm $(docker ps -a -q)'
alias dci='docker rmi $(docker images | grep "^<none>" | awk '\''{print $7}'\'')'
alias vim='/usr/local/bin/nvim'
alias testse='cd ~/Sites/shop-gant && bin/phpunit -c app_se/phpunit.xml.dist'
alias testuk='cd ~/Sites/shop-gant && bin/phpunit -c app/phpunit.xml.dist'
alias testphx='cd ~/Sites/shop-gant/vendor/markup/phoenix && bin/phpunit'

# Tidy PWD
bash_prompt_command() {
    local pwdmaxlen=40
    local trunc_symbol="…"
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

# Git staging/index indicator
git_status() {

    hg root >/dev/null 2>/dev/null && echo '☿ ' && return

    modified_files=`git diff --raw 2> /dev/null`
    untracked_files=`git ls-files --others --exclude-standard 2> /dev/null`
    status=''

	if [ "$(git status 2> /dev/null | tail -n1)" != "nothing to commit, working tree clean" ] ; then # We have staged files
       status="▲"
    fi

    if [ "$modified_files" ]; then # override staged indicator
       status="!"
    fi

    if [ "$untracked_files" ]; then # but deal with untracked files first
      status="?"
    fi

    # are we in a git repo?
    git branch >/dev/null 2>&1 && echo "±${status} " && return
    echo '• '
}


# Colours
#
# 0 - Black
# 1 - Red
# 2 - Green
# 3 - Yellow
# 4 - Blue
# 5 - Magenta
# 6 - Cyan
# 7 - White

#COL1=$(tput bold)$(tput setaf 2) # Green (bold)
COL1='\e[1;32m'
#COL2=$(tput bold)$(tput setaf 5) # Magenta (bold)
COL2='\e[1;35m'
#COL3=$(tput dim)$(tput setaf 7) # White (bold)
COL3='\e[1;37m'
#COL4=$(tput setaf 7)             # White (normal)
COL4='\e[0;37m'

PROMPT_COMMAND=bash_prompt_command
git_status="\[$COL1\]"'$(git_status)'
user_time="\[$COL2\]\u\[$COL3\]@\h [\#|\!] "
current_dir="\[$COL1\]"'$NEW_PWD '
source ~/.git-prompt.sh
dvcs_status="\[$COL3\]\[$COL2\]"'$(__git_ps1 "(%s)")'"\[$COL4\]"
docker_machine="\[$COL3\]\[$COL2\]"'$(__docker_machine_ps1)'"\n: \[$COL4\]"


PS1=$git_status$user_time$current_dir$dvcs_status$docker_machine

if [ "$(uname)" == "Darwin" ]; then
	source ~/.bashrc_darwin
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	source ~/.bashrc_linux
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	source ~/.bashrc_windows
fi

# dont commit e.g. homebrew token secrets
source ~/.bashrc_secrets

export PATH
