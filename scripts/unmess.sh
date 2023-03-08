#!/usr/bin/env bash

cd $(dirname "$0")/../www/images || exit

for file in 1*.jpg; do
    mv "$file" "${file/1/A}"
done
for file in 2*.jpg; do
    mv "$file" "${file/2/1}"
done
for file in 3*.jpg; do
    mv "$file" "${file/3/2}"
done
for file in 4*.jpg; do
    mv "$file" "${file/4/3}"
done
for file in 5*.jpg; do
    mv "$file" "${file/5/4}"
done
for file in A*.jpg; do
    mv "$file" "${file/A/5}"
done
