#!/usr/bin/env bash

bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-mock
bats_load_library extensions
bats_load_library sandbox

import files

@test "file_path should return \$D if no argument specified" {
  run file_path ''
  assert_output "$D"
}

@test "file_path should return \$D relative path" {
  run file_path 'some/non_existant/directory'
  assert_output "$D/some/non_existant/directory"
}

@test 'file_path should compose path from all arguments' {
  run file_path 'some' 'non_existant' 'directory'
  assert_output "$D/some/non_existant/directory"
}

@test 'file_path should not duplicate directory separator' {
  run file_path 'some' '/non_existant' '/directory'
  assert_output "$D/some/non_existant/directory"

  run file_path 'some/' 'non_existant/' 'directory/'
  assert_output "$D/some/non_existant/directory"
}

@test 'file_path should respect absolute paths' {
  run file_path '/some' 'absolute' 'path'
  assert_output '/some/absolute/path'
}

@test "file_link should link source file as \$D relative target file" {
  run file_link 'source_file' 'target_file'
  assert_symlink_to "$W/source_file" "$D/target_file"
}

@test 'file_link should ensure target path' {
  run file_link 'source_file' 'directory/target_file'
  assert_symlink_to "$W/source_file" "$D/directory/target_file"
}

@test 'file_link should use 1st argument basename when target not provided' {
  run file_link 'source_file'
  assert_symlink_to "$W/source_file" "$D/source_file"
}

@test 'file_link should use 1st argument basename when target is a directory' {
  mkdir -p "$D/directory"

  run file_link 'source_file' 'directory'
  assert_symlink_to "$W/source_file" "$D/directory/source_file"
}

@test 'file_link should fail when target file already exists' {
  touch "$D/target_file"

  run file_link 'source_file' 'target_file'
  assert_failure
  assert_output --partial 'target_file already exists'
}

@test 'file_link should success when target file already exists and link to same source' {
  ln -s "$W/source_file" "$D/target_file"

  run file_link 'source_file' 'target_file'
  assert_success
  assert_output --partial 'target_file already installed (skipping)'
}

@test 'file_link should fail when target file already exists and link to other source' {
  ln -s "$W/source_file2" "$D/source_file"

  run file_link 'source_file'
  assert_failure
  assert_output --partial "source_file already exists and links to $W/source_file2"
}

@test "file_link should fail when target is outside \$D" {
  run file_link 'source_file' '../target_file'
  assert_failure
  assert_output --partial "target_file is forbidden as it is outside $D"
}

@test "file_unlink should remove file from \$D" {
  touch "$D/target_file"

  run file_unlink 'target_file'
  assert_success
  assert_not_exists "$D/target_file"
}

@test "file_unlink should fail when target is outside \$D" {
  run file_unlink '../some_file'
  assert_failure
  assert_output --partial "some_file is forbidden as it is outside $D"
}

@test "file_unlink should recursively remove target when is a directory" {
  mkdir -p "$D/some_directory/with_subdirectories"
  touch "$D/some_directory/with_subdirectories/and_files"

  run file_unlink 'some_directory'
  assert_success
  assert_dir_not_exists "$D/some_directory"
}

@test "file_unlink should cleanup empty directories in path" {
  mkdir -p "$D/some_directory/with_subdirectories"
  touch "$D/some_directory/with_subdirectories/and_files"

  run file_unlink 'some_directory/with_subdirectories'
  assert_success
  assert_dir_not_exists "$D/some_directory"
}
