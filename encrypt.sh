#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <file1> [file2 ...]"
  exit 1
fi

read -s -p "Enter passphrase for encryption: " PASSPHRASE
echo

for f in "$@"; do
  if [ ! -f "$f" ]; then
    echo "Skip: $f (not found)"
    continue
  fi
  gpg --batch --yes --passphrase "$PASSPHRASE" -c -o "${f}.gpg" "$f"
  if [ $? -eq 0 ]; then
    echo "Encrypted $f -> ${f}.gpg"
    # optionally remove original file (comment/uncomment next line as needed)
    # rm -f "$f"
  fi
done
