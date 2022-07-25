#!/usr/bin/env bash

bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-mock
bats_load_library extensions
bats_load_library sandbox

import xdg

@test "xdg_get_config should return \$D/.config relative paths" {
  run xdg_get_config
  assert_output "$D/.config"

  run xdg_get_config 'some_file'
  assert_output "$D/.config/some_file"
}

@test "xdg_get_local should return \$D/.local/share relative paths" {
  run xdg_get_local
  assert_output "$D/.local/share"

  run xdg_get_local 'some_file'
  assert_output "$D/.local/share/some_file"
}

@test "xdg_get_cache should return \$D/.cache relative paths" {
  run xdg_get_cache
  assert_output "$D/.cache"

  run xdg_get_cache 'some_file'
  assert_output "$D/.cache/some_file"
}

@test "xdg_get_bin should return \$D/.local/bin relative paths" {
  run xdg_get_bin
  assert_output "$D/.local/bin"

  run xdg_get_bin 'some_file'
  assert_output "$D/.local/bin/some_file"
}
