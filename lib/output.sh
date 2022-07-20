#!/usr/bin/env sh
#shellcheck disable=SC3037 ## echo arguments are known to work in FreeBSD, OSX and most linux distributions

move_cursor() { echo -ne "\\e[$1;$2H"; }
save_cursor() { echo -ne '\\e7'; }
restore_cursor() { echo -ne '\\e8'; }
hide_cursor() { echo -ne '\\e[?25l'; }
show_cursor() { echo -ne '\\e[?25h'; }
save_screen() { echo -ne "\\e[?47h"; }
restore_screen() { echo -ne '\\e[?47l'; }
clear_line_right() { echo -ne '\\e[0K'; }
clear_line_left() { echo -ne '\\e[1K'; }
clear_line_all() { echo -ne '\\e[2K'; }

bold() { echo -ne "\\e[1m$*\\e[21m"; }
dim() { echo -ne "\\e[2m$*\\e[22m"; }
underline() { echo -ne "\\e[4m$*\\e[24m"; }
reverse() { echo -ne "\\e[7m$*\\e[27m"; }
hide_text() { echo -ne "\\e[8m$*\\e[28m"; }

fg_black() { echo -ne "\\e[30m$*\\e[39m"; }
fg_red() { echo -ne "\\e[31m$*\\e[39m"; }
fg_green() { echo -ne "\\e[32m$*\\e[39m"; }
fg_yellow() { echo -ne "\\e[33m$*\\e[39m"; }
fg_blue() { echo -ne "\\e[34m$*\\e[39m"; }
fg_magenta() { echo -ne "\\e[35m$*\\e[39m"; }
fg_cyan() { echo -ne "\\e[36m$*\\e[39m"; }
fg_white() { echo -ne "\\e[37m$*\\e[39m"; }

bg_black() { echo -ne "\\e[40m$*\\e[49m"; }
bg_red() { echo -ne "\\e[41m$*\\e[49m"; }
bg_green() { echo -ne "\\e[42m$*\\e[49m"; }
bg_yellow() { echo -ne "\\e[43m$*\\e[49m"; }
bg_blue() { echo -ne "\\e[44m$*\\e[49m"; }
bg_magenta() { echo -ne "\\e[45m$*\\e[49m"; }
bg_cyan() { echo -ne "\\e[46m$*\\e[49m"; }
bg_white() { echo -ne "\\e[47m$*\\e[49m"; }

DOTFILES_LOGLEVEL_DEBUG=3
DOTFILES_LOGLEVEL_INFO=2
DOTFILES_LOGLEVEL_WARN=1
DOTFILES_LOGLEVEL_ERROR=0
DOTFILES_LOGLEVEL=${DOTFILES_LOGLEVEL:-$DOTFILES_LOGLEVEL_INFO}
LOG_PREFIX=

set_log_level() { DOTFILES_LOGLEVEL="${1:-${DOTFILES_LOGLEVEL_INFO}}"; }

debug() {
  set +x
  [ "$DOTFILES_LOGLEVEL" -ge "$DOTFILES_LOGLEVEL_DEBUG" ] && echo -e "$(fg_white "$(date '+%F %X') [DEBUG]$LOG_PREFIX $*")" >&2
  [ "$DOTFILES_TRACE" -gt 0 ] && set -x
}

info() {
  set +x
  [ "$DOTFILES_LOGLEVEL" -ge "$DOTFILES_LOGLEVEL_INFO" ] && echo -e "$(fg_blue "$(date '+%F %X') [INFO ]$LOG_PREFIX $*")" >&2
  [ "$DOTFILES_TRACE" -gt 0 ] && set -x
}

warn() {
  set +x
  [ "$DOTFILES_LOGLEVEL" -ge "$DOTFILES_LOGLEVEL_WARN" ] && echo -e "$(fg_yellow "$(date '+%F %X') [WARN ]$LOG_PREFIX $*")" >&2
  [ "$DOTFILES_TRACE" -gt 0 ] && set -x
}

error() {
  set +x
  [ "$DOTFILES_LOGLEVEL" -ge "$DOTFILES_LOGLEVEL_ERROR" ] && echo -e "$(fg_red "$(date '+%F %X') [ERROR]$LOG_PREFIX $*")" >&2
  [ "$DOTFILES_TRACE" -gt 0 ] && set -x
}

die() {
  error "$*"
  exit 1
}
