function _git_duet_enabled() {
  command -v git-duet >/dev/null &&
    git config --get duet.env.git-committer-initials >/dev/null 2>&1
}

function _git_duet_commit() {
  if _git_duet_enabled; then
    git duet-commit $@
  else
    git commit $@
  fi
}

function _git_duet_merge() {
  if _git_duet_enabled; then
    git duet-merge $@
  else
    git merge $@
  fi
}

unalias gc
unalias gc!
unalias gca
unalias gcam
unalias gcan!
unalias gcans!
unalias gcas
unalias gcasm
unalias gcmsg
unalias gcn!
unalias gcs
unalias gcsm
unalias gm
unalias gmom
unalias gmum
unalias grv
unalias grbi

function gc() { _git_duet_commit -v $@; }
function gc!() { _git_duet_commit -v -i $@; }
function gca() { _git_duet_commit -v -a $@; }
function gcam() { _git_duet_commit -v -a --amend $@; }
function gcan!() { _git_duet_commit -v -a -m $@; }
function gcans!() { _git_duet_commit -v -a --no-edit --amend $@; }
function gcas() { _git_duet_commit -v -a -s $@; }
function gcasm() { _git_duet_commit -v -a -s -m $@; }
function gcmsg() { _git_duet_commit -v -m $@; }
function gcn!() { _git_duet_commit -v --no-edit --amend $@; }
function gcs() { _git_duet_commit -v -S $@; }
function gcsm() { _git_duet_commit -v -S -m $@; }
function gm() { _git_duet_merge -v $@; }
function gmom() { _git_duet_merge -v origin/$(git_main_branch) $@; }
function gmum() { _git_duet_merge -v upstream/$(git_main_branch) $@; }
function grv() {
  if _git_duet_enabled; then
    git duet-revert $@
  else
    git revert $@
  fi
}
function grbi() {
  if _git_duet_enabled; then
    git rebase -i --exec "git duet-commit --amend" $@
  else
    git rebase -i $@
  fi
}

function prompt_pairing() {
  local state=
  local text=
  local icon=

  $(git remote get-url origin >/dev/null 2>&1) || return

  if _git_duet_enabled; then
    local author_name=$(git config --get duet.env.git-author-initials)
    local committer_name=$(git config --get duet.env.git-committer-initials)

    if [[ $author_name ]]; then
      state=solo
      text="$author_name"
    fi

    if [[ $committer_name ]]; then
      state=duet
      text="$author_name, $committer_name"
    fi
  else
    state=solo
    text=$(git config --get user.name)
  fi

  if [[ $state ]]; then
    if [[ "$state" -eq 'duet' ]]; then
      icon='👤'
    else
      icon='👥'
    fi
    p10k segment -s "$state" -t "$text" -i "$icon" -f gray
  fi
}
