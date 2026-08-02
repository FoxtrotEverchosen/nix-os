#!/usr/bin/env bash
set -e
pushd /etc/nixos/
sudo nvim configuration.nix
sudo alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding ..."
sudo nixos-rebuild switch &>/tmp/nixos-switch.log || (
  cat /tmp/nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
