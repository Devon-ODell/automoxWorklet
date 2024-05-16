
#!/bin/bash

#================================================================
# HEADER
#================================================================
# SYNOPSIS
#   Installs and registers the Drata Agent on the target macOS device
#
# DESCRIPTION
#   This script checks if the Drata Agent is installed on the target
#   device. If not installed, it installs the Drata Agent and registers
#   it with the provided site token.
#
# USAGE
#   ./DrataAgentRemedy.sh
#
# EXAMPLE
#   dmg_filename="Drata-Agent-3.4.1-universal.dmg"
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
dmg_filename="Drata-Agent-3.4.1-universal.dmg"
site_token="ABCD123"
#########################

# CONSTANTS
script_dir=$(dirname "$0")
drata_agent_app="/System/Applications/Drata-Agent-3.4.1-universal.app"
dmg_installer="$script_dir/MacOS/$dmg_filename"

#########################

# Check if Drata Agent is already installed
if [ -d "$drata_agent_app" ]; then
    echo "Drata Agent is already installed"
    exit 0
elif [ "$(find /System/Applications -name  'Drata*.app' -print -quit)" ]; then
    echo "Another version is already installed... "
    exit 1
else
    echo "Drata Agent is not installed. Installing..."

    # Mount the disk image
    MOUNT_POINT=$(hdiutil mount "$dmg_installer" | awk '/\/Volumes/ {print $3}')

    # Copy the Drata Agent application to the /System/Applications directory
    sudo cp -R "${MOUNT_POINT}/Drata-Agent-3.4.1-universal.app" /System/Applications/

    # Unmount the disk image
    hdiutil unmount "${MOUNT_POINT}"
fi

# Register the Drata Agent
echo "Registering Drata Agent..."
/System/Applications/Drata-Agent-3.4.1-universal.app/Contents/MacOS/drata-agent-register "$site_token"

echo "Drata Agent registration completed."
