if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export PATH=$PATH:~/bin

# homebrew bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
	. "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
fi
export GPG_TTY=$(tty)

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

#homebrew
export HOMEBREW_GITHUB_API_TOKEN=4ca74b552f05492444415ff87f7e2cf7ffd01a88
