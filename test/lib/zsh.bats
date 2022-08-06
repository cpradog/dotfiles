#!/usr/bin/env bash

bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-mock
bats_load_library extensions
bats_load_library sandbox

import zsh

@test 'zsh_add_rc should link file and regenerate zshrc file' {
  expected='some template file'
  echo "$expected" >"$W/template"

  run zsh_add_rc "template"
  assert_symlink_to  "$W/template" "$D/.local/share/zsh/rc.d/template"
  assert_file_exists "$D/.zshrc"
  assert_file_contains "$D/.zshrc" "$expected"
}

@test 'zsh_del_rc should unlink file and regenerate zshrc file' {
  mkdir -p "$D/.local/share/zsh/rc.d"
  touch "$D/.local/share/zsh/rc.d/template"

  run zsh_del_rc "template"
  assert_file_exists "$D/.zshrc"
  assert_file_not_contains "$D/.zshrc" "$D/.local/share/zsh/rc.d/template"
  assert_file_not_exists "$D/.local/share/zsh/rc.d/template"
}

@test 'zsh_add_env should link file and regenerate zshenv file' {
  expected='some template file'
  echo "$expected" >"$W/template"

  run zsh_add_env "template"
  assert_symlink_to  "$W/template" "$D/.local/share/zsh/env.d/template"
  assert_file_exists "$D/.zshenv"
  assert_file_contains "$D/.zshenv" "$expected"
}

@test 'zsh_del_env should unlink file and regenerate zshenv file' {
  mkdir -p "$D/.local/share/zsh/env.d"
  touch "$D/.local/share/zsh/env.d/template"

  run zsh_del_env "template"
  assert_file_exists "$D/.zshenv"
  assert_file_not_contains "$D/.zshenv" "$D/.local/share/zsh/env.d/template"
  assert_file_not_exists "$D/.local/share/zsh/env.d/template"
}
