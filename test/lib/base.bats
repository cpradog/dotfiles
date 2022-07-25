#!/usr/bin/env bash

bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-mock
bats_load_library sandbox

@test "import should source runtime relative modules" {
  DOTFILES_LIB="$DOTFILES_FIXTURES/runtime" import module
  run module_function
  assert_output --partial 'module function called'
}

@test "import should source all arguments" {
  DOTFILES_LIB="$DOTFILES_FIXTURES/runtime" import module module2 module3 module4
  run module_function
  assert_output --partial 'module function called'

  run module2_function
  assert_output --partial 'module2 function called'

  run module3_function
  assert_output --partial 'module3 function called'

  run module4_function
  assert_output --partial 'module4 function called'
}

@test "import should fail if one argument doesn't exists" {
  LC_ALL=C run import invalid_module_name

  assert_failure
  assert_output --partial "No such file or directory"
}
