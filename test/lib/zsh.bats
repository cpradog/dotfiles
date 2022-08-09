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

@test 'zsh_add_plugin should register antibody plugin and regenerate init script' {
  run zsh_add_plugin 'supercrabtree/k'
  assert_success
  assert_file_exist "$D/.local/share/zsh/antibody/plugins"
  assert_file_contains "$D/.local/share/zsh/antibody/plugins" 'supercrabtree/k'
  assert_file_exist "$D/.cache/zsh/antibody/init.zsh"
}

@test 'zsh_del_plugin should remove antibody plugin and regenerate init script' {
  mkdir -p "$D/.local/share/zsh/antibody"
  echo "supercrabtree/k" >> "$D/.local/share/zsh/antibody/plugins"
  echo "some/plugin" >> "$D/.local/share/zsh/antibody/plugins"

  run zsh_del_plugin 'some/plugin'
  assert_success
  assert_file_exist "$D/.local/share/zsh/antibody/plugins"
  assert_file_contains "$D/.local/share/zsh/antibody/plugins" 'supercrabtree/k'
  assert_file_not_contains "$D/.local/share/zsh/antibody/plugins" 'some/plugin'
  assert_file_exist "$D/.cache/zsh/antibody/init.zsh"
}

@test 'zsh_del_plugin should not fail if antibody plugins file is not pressent' {
  run zsh_del_plugin 'some/plugin'
  assert_success
  assert_file_not_exist "$D/.local/share/zsh/antibody/plugins"
  assert_file_not_exist "$D/.cache/zsh/antibody/init.zsh"

}
