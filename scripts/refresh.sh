#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  echo "Give image numbers, like:"
  echo "./refresh.sh 100 101 102 200 201 202 300 301 302 400 401 402 500 501 502"
  exit 1
fi

for img in "$@"
do
  echo "$img"
  curl -s localhost:8080/images/"$img".jpg -H 'X-Update-Cache: true' -o /dev/null
done
