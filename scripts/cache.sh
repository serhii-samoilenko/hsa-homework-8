#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  echo "Give image numbers."
  exit 1
fi

for img in "$@"
do
  echo "$img"
  curl -s localhost:8080/images/"$img".jpg -H 'X-Update-Cache: true' -o /dev/null
done
