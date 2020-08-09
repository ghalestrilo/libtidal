# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH_THEME="lalis"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  last-working-dir
  copybuffer
  # systemd
  # colorize
  docker-compose
  # debian
  # ubuntu
  # npm
  # nvm
  # react-native
  sudo
  themes
  tmux
  z
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export REACT_EDITOR="codium"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="kak ~/.zshrc"

# alias ohmyzsh="mate ~/.oh-my-zsh"
eval $(thefuck --alias)
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$HOME/.ghcup/ghc/8.6.5/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Custom Exports
export SC_REC_DIR="$HOME/.local/share/SuperCollider/Recordings/"
export TIDAL_BOOT_PATH="$HOME/git/dots/tidal/boot.tidal"

# Record Screen (Video only)
alias rec="ffmpeg -video_size 3840x2160 -framerate 25 -f x11grab -i :0.0 output.mp4"

alias recs="cd $SC_REC_DIR"
alias zc="kak ~/.zshrc"
alias refresh="source ~/.zshrc"
alias save="cd ~/git/config && bash ./scripts/updateconfig.sh reverse; cd $pwd"


# Quality of life
alias short='xdg-open https://trello.com/b/xYvCoiBo/short'

# TODO: Change this to atom on ubuntu regolith, create .zshrc for ubuntu
alias config="codium ~/git/dots"

alias ff="~/.cabal/bin/feedforward 2> ~/err.txt"

# lol
alias killdiablo='wine "C:/Games/Diablo II/Diablo II.exe"'
alias cheatdiablo='wine "C:/Games/Diablo II/Diablo II.exe" -nosave'

if [ -d $HOME/.config/broot ]; then
	source $HOME/.config/broot/launcher/bash/br
fi

# NVM path
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Start a Tidal Jam Session
alias jam="i3-msg 'workspace jam; layout splitv; \
    exec alacritty --title supercollider -e sclang; \
    exec alacritty --title cava -e cava; \
    exec alacritty --title tidal -e nvim ~/art'; \
    exec alacritty --title cninjam -e cninjam jam.miniestereo.org:2049 -user anonymous:ghales -jack \
  && sleep 0.2 \
  && i3-msg '[title=tidal] focus; move left'"

# Start a Tidal Jam Session
#  alias jam="i3-msg 'workspace jam; exec alacritty -e sclang; exec alacritty -e cava; exec alacritty --title tidal -e nvim ~/art' \
#   && sleep 0.2 \
#   && i3-msg '[title=tidal] focus; move left'"
