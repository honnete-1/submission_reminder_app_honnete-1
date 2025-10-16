
#!/bin/bash

# Check if config.env exists
if [ ! -f "config.env" ]; then
    echo "Error: config.env file not found at $config_file"
    exit 1
fi

# Replace the ASSIGNMENT value in config.env using sed
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$assignment_name\"/" "$config.env"

echo "Assignment name updated to: $assignment_name"
echo "Updated config file:"
cat "$config.env"
echo ""
echo "Running startup.sh to check submissions for the new assignment..."
echo "--------------------------------------------"

# Run the startup.sh script
cd "$App_Dir" && ./startup.sh

# Run the startup.sh script
cd "$App_Dir" && ./startup.sh
./"$App_Dir/app/reminder.sh"
" > "$App_Dir/startup.sh"
