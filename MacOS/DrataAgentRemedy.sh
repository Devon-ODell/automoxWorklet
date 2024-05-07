#!/bin/bash
#================================================================
# HEADER
#================================================================
#  SYNOPSIS
# 
#  DESCRIPTION
#    This worklet checks to see if the Drata Agent is installed
#    on the target device and if it isn't, installs and registers the
#    Drata Agent on the device.
#
#  USAGE
#    ./Executables/DrataLogin.sh
#
#  EXAMPLE
#    dmg="Drata-Agent-3.4.1-universal.dmg"
#    site_token="ABCD123"
#
#================================================================
#  IMPLEMENTATION
#    version Automox-Drata-Agent-v0.0
#    author Yours Truly
#================================================================
# END_OF_HEADER
#================================================================

#########################
dmg_filename="Drata-Agent-3.4.1-universal.dmg"
site_token="ABC123"
#########################
# CONSTANTS
dmg_installer="$(pwd)/$dmg_filename"
#########################

# Check if Drata Agent is already installed
if sudo dratactl version > /dev/null; then
  echo "Software is already installed"
  exit 0
fi

install_command=""
# Define install command based on system type
if [ -x "$(command -v dpkg)" ]; then
  echo "Installing $dmg_installer"

  install_command="sudo dpkg -i $dmg_installer"
elif [ -x "$(command -v dmg)" ]; then
  echo "Installing $dmg_installer"

  install_command="sudo dmg -i --nodigest $dmg_installer"
else
  echo "Unable to install software; either dmg or dpkg package manager must be present on system"
  exit 1
fi

if eval "$install_command"; then
  echo "Software successfully installed"

  echo "Registering SentinelOne agent"
  sudo /opt/drataAgent/bin/drataAgent management token set "$site_token"
  sudo /opt/drataAgent/bin/drataAgent control start
  exit 0
else
  echo "Software failed to install"
  exit 1
fi
