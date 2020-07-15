#福

#DOT=·
DOT=">"

MAINCOLOR=green
COLOR2=blue
COLOR3=blue


DIRECTORY=$fg_bold[$MAINCOLOR]
INPUT=$fg_no_bold[$MAINCOLOR]
NAME=$fg[$COLOR2]

PROMPT='%{$DIRECTORY%} %c | %{$INPUT%}'
RPROMPT='%f $(git_prompt_status)$(git_prompt_info) %{$DIRECTORY%}| %{$NAME%}%n · %F{$MAINCOLOR}%D{%L:%M} %F{$MAINCOLOR}%D{%p}%{$INPUT%}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{$COLOR3} %{$fg_no_bold[$COLOR2]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""


#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[]%}$DOT"

ZSH_THEME_GIT_PROMPT_STAGED_ADDED="%{$fg[cyan]%}$DOT"
ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED="%{$fg[yellow]%}$DOT"
ZSH_THEME_GIT_PROMPT_STAGED_DELETED="%{$fg[red]%}$DOT"
ZSH_THEME_GIT_PROMPT_STAGED_RENAMED="%{$fg[blue]%}$DOT"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}$DOT"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}$DOT"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}$DOT"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}$DOT"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[gray]%}$DOT"

ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ÷" # ✂
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}|%{$fg_no_bold[green]%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[green]%}$DOT"

# Highlighting (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline
# ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue