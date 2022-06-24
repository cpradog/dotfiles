cat <<EOF
# enable fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$${FZF_DEFAULT_COMMAND}"
EOF

cat '/usr/share/fzf/key-bindings.zsh' 2>/dev/null
cat "${XDG_DATA_HOME}/fzf/key-bindings.zsh" 2>/dev/null
