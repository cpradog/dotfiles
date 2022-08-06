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

@test "xdg_get_data should return \$D/.local/share relative paths" {
  run xdg_get_data
  assert_output "$D/.local/share"

  run xdg_get_data 'some_file'
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

@test "xdg_link_config should link files into \$D/.config directory" {
  mkdir -p "$W/files"
  run xdg_link_config 'files/source_file'
  assert_symlink_to "$W/files/source_file" "$D/.config/source_file"
}

@test "xdg_link_config should allow to specify relative target path" {
  run xdg_link_config 'source_file' 'subdir/target_file'
  assert_symlink_to "$W/source_file" "$D/.config/subdir/target_file"
}

@test "xdg_link_data should link files into \$D/.local/share directory" {
  mkdir -p "$W/files"
  run xdg_link_data 'files/source_file'
  assert_symlink_to "$W/files/source_file" "$D/.local/share/source_file"
}

@test "xdg_link_data should allow to specify relative target path" {
  run xdg_link_data 'source_file' 'subdir/target_file'
  assert_symlink_to "$W/source_file" "$D/.local/share/subdir/target_file"
}

@test "xdg_link_cache should link files into \$D/.cache directory" {
  mkdir -p "$W/files"
  run xdg_link_cache 'files/source_file'
  assert_symlink_to "$W/files/source_file" "$D/.cache/source_file"
}

@test "xdg_link_cache should allow to specify relative target path" {
  run xdg_link_cache 'source_file' 'subdir/target_file'
  assert_symlink_to "$W/source_file" "$D/.cache/subdir/target_file"
}

@test "xdg_link_bin should link files into \$D/.local/bin directory" {
  mkdir -p "$W/files"
  run xdg_link_bin 'files/source_file'
  assert_symlink_to "$W/files/source_file" "$D/.local/bin/source_file"
}

@test "xdg_link_bin should allow to specify relative target path" {
  run xdg_link_bin 'source_file' 'subdir/target_file'
  assert_symlink_to "$W/source_file" "$D/.local/bin/subdir/target_file"
}

@test "xdg_unlink_config should remove file from \$D/.config directory" {
  mkdir -p "$D/.config"
  touch "$D/.config/target_file"

  run xdg_unlink_config 'target_file'
  assert_success
  assert_not_exists "$D/.config/target_file"
}

@test "xdg_unlink_data should remove file from \$D/.local/share directory" {
  mkdir -p "$D/.local/share"
  touch "$D/.local/share/target_file"

  run xdg_unlink_data 'target_file'
  assert_success
  assert_not_exists "$D/.local/share/target_file"
}

@test "xdg_unlink_cache should remove file from \$D/.cache directory" {
  mkdir -p "$D/.cache"
  touch "$D/.cache/target_file"

  run xdg_unlink_cache 'target_file'
  assert_success
  assert_not_exists "$D/.cache/target_file"
}

@test "xdg_unlink_bin should remove file from \$D/.local/bin directory" {
  mkdir -p "$D/.local/bin"
  touch "$D/.local/bin/target_file"

  run xdg_unlink_bin 'target_file'
  assert_success
  assert_not_exists "$D/.local/bin/target_file"
}
