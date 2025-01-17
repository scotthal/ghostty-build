#!/bin/sh

cd $HOME/ghostty
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-shell --run "zig build -Doptimize=ReleaseFast"

