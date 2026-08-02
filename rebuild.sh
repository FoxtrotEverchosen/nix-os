#!/usr/bin/env bash
set -e
pushd /etc/nixos/
sudo nvim configuration.nix
alejandra . &>/dev/null
sudo git diff -U0 *.nix
echo "NixOS Rebuilding ..."
sudo nixos-rebuild switch &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
sudo git commit -am "$gen"
popd
