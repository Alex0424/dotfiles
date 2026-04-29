#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[INFO] Setting up config dotfiles..."

mkdir -p "$HOME/.config/"

for file in "$REPO_ROOT/.config"/*; do
  file_name="$(basename "$file")"
  case "$file_name" in
    *.md|.git*)
      continue
      ;;
  esac

  src="$file"
  dest="$HOME/.config/$file_name"

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "[Conflict] $dest already exists"
    ls -l "$dest"

    read -p "[Q&A] Replace $dest with symlink? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
      rm -rf -- "$dest"
    else
      echo "[SKIP] $file_name"
      continue
    fi
  else
    read -p "[Q&A] Link $file_name → $dest? (y/n): " answer
    if [[ "$answer" != "y" ]]; then
      echo "[SKIP] $file_name"
      continue
    fi
  fi

  ln -s "$src" "$dest"
  echo "[OK] Linked $file_name"
done

echo "[INFO] Setting up home dotfiles..."

for file in "$REPO_ROOT"/.[!.]*; do
  file_name="$(basename "$file")"
  case "$file_name" in
    *.md|*.sh|.git|scripts|images|test|.config|.dotfiles-root)
      continue
      ;;
  esac

  src="$file"
  dest="$HOME/$file_name"

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "[Conflict] $dest already exists"
    ls -l "$dest"
    read -p "[Q&A] Replace $dest with symlink? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
      rm -rf -- "$dest"
    else
      echo "[SKIP] $file_name"
      continue
    fi
  else
    read -p "[Q&A] Link $file_name → $dest? (y/n): " answer
    if [[ "$answer" != "y" ]]; then
      echo "[SKIP] $file_name"
      continue
    fi
  fi

  ln -s "$src" "$dest"
  echo "[OK] Linked $file_name"
done
