#!/usr/bin/env bash
PRINCIPAL='DisplayPort-0'

killall polybar

list=$(polybar -m | sed 's/:.*//g' | tr '\n' ' ')
IFS=' ' read -r -a outputs <<< "$list"
for output in "${outputs[@]}"
do
  bar='secondary'

  if [[ "$output" = "$PRINCIPAL" ]]
  then
    bar='principal'
  fi

  MONITOR=$output polybar -r $bar &
done
