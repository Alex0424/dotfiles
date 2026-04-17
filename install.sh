#!/usr/bin/env bash

set -e

repo_absolute_path="$PWD"

echo "[INFO] Setting up dotfiles..."

mkdir -p "$HOME/.config/"

for file in *;
do
  case "$file" in
    *.md|.git*|*.sh)
      continue
      ;;
  esac

  src="$repo_absolute_path/$file"
  dest="$HOME/.config/$file"

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "[Conflict] $dest already exists"
    ls -l "$dest"

    read -p "[Q&A] Replace it with symlink? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
      rm -rf -- "$dest"
    else
      echo "[SKIP] $file"
      continue
    fi
  else
    read -p "[Q&A] Link $file → $dest? (y/n): " answer
    if [[ "$answer" != "y" ]]; then
      echo "[SKIP] $file"
      continue
    fi
  fi

  ln -s "$src" "$dest"
  echo "[OK] Linked $file"
done
