#!/usr/bin/env bash

build_nix() {
  echo "❄️ Building config for Nix..."
  nix build .
  if [ ! -e ./result/bin/nvim ]; then
    echo "🚫 Build failed, exiting"
    exit 1
  fi
  echo "📂 Adding result to path..."
  mkdir -p ~/.local/bin
  ln -s ./result/bin/nvim ~/.local/bin
  echo "✅ Done!"
}

build_vanilla() {
  echo "❌ Not implemented. Exiting"
  exit 1
}

usage() {
  echo "Usage: $0 [nix|vanilla]"
  exit 1
}

if [ $# -ne 1 ]; then
  usage
fi

MODE="$1"
if [ "$MODE" = "nix" ]; then
  build_nix
elif [ "$MODE" = "vanilla" ]; then
  build_vanilla
else
  usage
fi
