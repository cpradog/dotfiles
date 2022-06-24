# enable stack completions
if command -v stack &> /dev/null; then
  eval "$(stack --bash-completion-script stack)"
fi
