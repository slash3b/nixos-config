#! /usr/bin/env bash

sudo nixos-rebuild switch -I nixos-config=configuration.nix
sudo echo "RP12" > /proc/acpi/wakeup
sudo echo "GLAN" > /proc/acpi/wakeup
sudo echo "XHC" > /proc/acpi/wakeup
# https://gist.github.com/slash3b/c15e895e92ffec018b81fa40326088b7
# hacky but for now is good
