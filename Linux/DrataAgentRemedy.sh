#!/bin/bash

#================================================================
# HEADER
#================================================================
# SYNOPSIS
#   Installs the Drata Agent on the target Linux system
#
# DESCRIPTION
#   This script checks if the Drata Agent is installed on the target
#   Linux system, and if it isn't, installs and registers the Drata
#   Agent on the device.
#
# USAGE
#   ./drata_agent_install.sh
#
# EXAMPLE
#   deb_filename="drata-agent_3.4.1_amd64.deb"
#   site_token="ABCD123"
#
#================================================================
# IMPLEMENTATION
#   version Automox-Drata-Agent-v0.0
#   author Your Name
#================================================================
# END_OF_HEADER
#================================================================

#########################
deb_filename="drata-agent_3.4.1_amd64.deb"
site_token="ABC123"
#########################

# CONSTANTS
script_dir=$(dirname "$0")
deb_installer="$script_dir/$deb_filename"

#########################

# Check if Drata Agent is already installed
if drata_agent_check_command > /dev/null; then
    echo "Drata Agent is already installed"
    exit 0
fi

# Install the Drata Agent
echo "Installing $deb_installer"
if sudo dpkg -i "$deb_installer"; then
    echo "Drata Agent installed successfully"
else
    echo "Failed to install Drata Agent"
    exit 1
fi

# Register the Drata Agent
# Replace 'drata_agent_registration_command' with the actual command or script
# provided by Drata to register the agent
drata_agent_registration_command "$site_token"

if [ $? -eq 0 ]; then
    echo "Drata Agent registered successfully"
else
    echo "Failed to register Drata Agent"
    exit 1
fi