#!/bin/bash

#================================================================
# HEADER
#================================================================
#  SYNOPSIS
#    Installs the Drata Agent on the target device
#
#  DESCRIPTION
#    This worklet checks to see if the Drata Agent is installed
#    on the target device
#  USAGE
#    ./remediation.sh
#
#  EXAMPLE
#    deb_filename="Drata-Agent-linux.deb"
#
#================================================================
# END_OF_HEADER
#================================================================


#########################
deb_filename="Drata-Agent-linux.deb"
#########################
# CONSTANTS
deb_installer="$(pwd)/$deb_filename"

# Check if Drata is already installed
  if sudo dratactl version > /dev/null;
  echo "Software isn't installed"
elif sudo dratactl version > /dev/(v3.4.1)
  echo "Software is already installed"
else
  echo "Error"
fi

