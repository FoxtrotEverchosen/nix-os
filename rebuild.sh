set -e
pushd /etc/nixos/
sudo nvim configuration.nix
sudo alejandra . &>/dev/null
sudo git diff HEAD --no-renames -U0
echo "NixOS Rebuilding ..."
sudo nixos-rebuild switch &>/tmp/nixos-switch.log || (
  cat /tmp/nixos-switch.log | grep --color error && false)
git commit -am "NixOS rebuild $(date '+%Y-%m-%d %H:%M')"
git push origin main
popd
