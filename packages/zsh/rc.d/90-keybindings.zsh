# restore home, end and delete keys
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[3~"   delete-char
bindkey "^[3;5~"  delete-char
bindkey '^[[A'    history-substring-search-up
bindkey '^[[B'    history-substring-search-down
