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
#    ./DrataAgentRemedy.sh
#
#
#  EXAMPLE
#    dmg_filename="Drata-Agent-mac.dmg"
#
#================================================================
# END_OF_HEADER
#================================================================


#########################
dmg_filename="Drata-Agent-mac.dmg"
#########################
# CONSTANTS
dmg_installer="$(pwd)/$dmg_filename"

# Check if Drata is already installed
  if sudo dratactl version > /dev/(v3.4.1=CURRENT_VERSION);
  echo "Software is already installed"
elif sudo dratactl version > /dev/null;
  echo "Software isn't installed"
else
  echo "Error"
fi

