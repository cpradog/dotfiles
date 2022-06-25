# restore home, end and delete keys
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[3~"   delete-char
bindkey "^[3;5~"  delete-char
bindkey '^[[A'    history-substring-search-up
bindkey '^[[B'    history-substring-search-down
# enable case insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# initialize completions
autoload -Uz compinit
autoload -U +X bashcompinit
compinit -d "${XDG_CACHE_HOME}/zcompdump"
bashcompinit
# enable history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="${ZSH_CACHE_DIR}/history"
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks
setopt hist_ignore_space
# disable glob not matching error
setopt no_nomatch

# enable local scripts
fpath=(${XDG_DATA_HOME}/zsh ${XDG_CONFIG_HOME}/zsh/scripts $fpath)
