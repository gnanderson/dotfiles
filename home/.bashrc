# command mode
set -o vi

export EDITOR=/usr/bin/vim
#export ZEND_TOOL_INCLUDE_PATH="/data/php5/ZendFramework/library"

## Amazon AWS CLi tool
#export EC2_HOME="/home/ganderson/bin/ec2"
#export AWS_RDS_HOME="/home/ganderson/bin/rdsc"
#export EC2_CERT=""
#export EC2_PRIVATE_KEY=""

# Extra PATH's
export PATH=$PATH:/home/ganderson/src/python/git-hg/bin

# Dotfiles
export DOTFILES_DIR=~/.dotfiles

# Chromium
export XDG_CACHE_HOME=/tmp

# Go
export PATH=$PATH:$GOBIN

test -s ~/.alias && . ~/.alias || true

# amazon tools path
#export PATH=$PATH:$EC2_HOME/bin:$AWS_RDS_HOME/bin

# LFS settings
export LFS=/mnt/lfs

# Tmux
#[[ $TERM != "screen" ]] && tmux attach && exit

# Aliases
alias oscb='osc build openSUSE_12.3'
alias oscba='osc build --no-verify openSUSE_12.3'
alias osca='osc -A https://obs.dev.andtech.eu:444'
alias scp='scp -p'
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"
alias bios='[ -f /usr/sbin/dmidecode ] && sudo -v && echo -n "Motherboard" && sudo /usr/sbin/dmidecode -t 1 | grep "Manufacturer\|Product Name\|Serial Number" | tr -d "\t" | sed "s/Manufacturer//" && echo -ne "\nBIOS" && sudo /usr/sbin/dmidecode -t 0 | grep "Vendor\|Version\|Release" | tr -d "\t" | sed "s/Vendor//"'
alias fixboot="su -c 'grub2-mkconfig -o /boot/grub2/grub.cfg'"

# Tidy PWD 
bash_prompt_command() {
    local pwdmaxlen=25
    local trunc_symbol="⋯"
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

    if [ "$(git status 2> /dev/null | tail -n1)" != "nothing to commit, working directory clean" ] ; then # We have staged files
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

hg_status() {
    hg prompt --angle-brackets "\
< on <branch>>\
< at <tags|, >>\
<status|modified|unknown><update><
patches: <patches|join( → )>>" 2>/dev/null
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
user_time="\[$COL2\]\u\[$COL3\]@\h [\t] "
current_dir="\[$COL1\]"'$NEW_PWD '
dvcs_status="\[$COL2\]"'$(__git_ps1 "(%s)")'$(hg_status)"\n: \[$COL4\]"

PS1=$git_status$user_time$current_dir$dvcs_status
