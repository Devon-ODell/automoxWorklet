#!/bin/bash

#================================================================
# HEADER
#================================================================
#  SYNOPSIS
#    Installs the Drata Agent on the target device
#
#  DESCRIPTION
#    This worklet installs and registers the
#    Drata Agent on the device.
#
#  USAGE
#    ./Executables/DrataLogin.sh
#
#  EXAMPLE
#  deb_filename="Drata-Agent-linux.deb"
#================================================================
# END_OF_HEADER
#================================================================

install_command=""
# Define install command based on system type
if [ -x "$(command -v dpkg)" ]; then
  echo "Installing $deb_installer"

  install_command="sudo dpkg -i $deb_installer"
elif [ -x "$(command -v rpm)" ]; then
  echo "Installing $deb_installer"

  install_command="sudo rpm -i --nodigest $deb_installer"
else
  echo "Unable to install software; deb package manager must be present on system"
  exit 1
fi

