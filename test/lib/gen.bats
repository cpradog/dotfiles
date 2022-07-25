#!/usr/bin/env bash

bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-mock
bats_load_library sandbox

import gen

@test 'gen_file should allow generate file from a template' {
  cat >"$W/template" <<EOF
<%= 'hello world!' %>
EOF

  run gen_file "$D/result" "$W/template"
  assert_success
  assert_file_contains "$D/result" "hello world!"
}

@test 'gen_file should allow generate file from multiple templates' {
  cat >"$W/template" <<EOF
<%= 'hello world!' %>
EOF
  cat >"$W/template2" <<EOF
<%= 'hello world2!' %>
EOF

  run gen_file "$D/result" "$W/template" "$W/template2"
  assert_success
  assert_file_contains "$D/result" "hello world!"
  assert_file_contains "$D/result" "hello world2!"
}

@test 'gen_file should allow generate file from a directory of templates' {
  cat >"$W/template" <<EOF
<%= 'hello world!' %>
EOF
  cat >"$W/template2" <<EOF
<%= 'hello world2!' %>
EOF

  run gen_file "$D/result" "$W"
  assert_success
  assert_file_contains "$D/result" "hello world!"
  assert_file_contains "$D/result" "hello world2!"
}

@test 'gen_file should sort template files' {
  cat >"$W/2-template" <<EOF
<%= 'hello world!' %>
EOF
  cat >"$W/1-template2" <<EOF
<%= 'hello world2!' %>
EOF

  run gen_file "$D/result" "$W"
  assert_success
  assert_equal "$(grep -vE '^(\s*$|#)' < "$D/result" | tr '\n' ' ')" \
               "hello world2! hello world! "
}
