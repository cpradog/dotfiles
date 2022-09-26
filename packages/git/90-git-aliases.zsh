alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev|development)\s*$)" | command xargs -n 1 git branch -d'
