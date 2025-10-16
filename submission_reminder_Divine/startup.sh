#!/bin/bash

# Get absolute path of this script
App_Root="\$(dirname "\$0")"

# Path to reminder.sh
reminder_script="$App_Root/app/reminder.sh"

# Check if config file exists
if [ ! -f "$App_Root/config/config.env" ]; then
    echo "Error: config.env not found. Please run this script from inside $script_dir"
    exit 1
fi

# Launch the reminder app
bash "$reminder_script"
echo "wow! Environment has been created successfully"
echo "To test the application run:"
echo "cd $App_Dir && ./startup.sh"
