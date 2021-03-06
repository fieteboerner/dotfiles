if [[ -z $ZSH_THEME_CLOUD_PREFIX ]]; then
	ZSH_THEME_CLOUD_PREFIX='☁'
fi
if [[ $UID == 0 || $EUID == 0 ]]; then
	fg_bold[cyan]=$fg_bold[red]
fi

ZSH_PREFIX_HOST=''
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        HOSTNAME=$(hostname)
        ZSH_PREFIX_HOST="[%{$fg_bold[red]%}$HOSTNAME%{$reset_color%}] "
fi

PROMPT='$ZSH_PREFIX_HOST%{$fg_bold[cyan]%}$ZSH_THEME_CLOUD_PREFIX %{$fg_bold[green]%}%3~ %{$fg[green]%}%{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"

