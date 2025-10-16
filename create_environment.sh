#!/bin/bash

read -p "Enter your name: " name
#making submission_reminder_{name} directory

App_Dir="submission_reminder_$name"
mkdir -p "$App_Dir"/{app,modules,assets,config}
#creating the files and their contents

app="$App_Dir/app"
modules="$App_Dir/modules"
assets="$App_Dir/assets"
config="$App_Dir/config"

#creation of config.env file and its contents
cat > "$config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#create reminder.sh shell script and its contents
cat > "$app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="$(dirname "$0")/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

#create functions.sh shell script and its contents
cat > "$modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#creation of submissions.txt file and its contents
cat > "$assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
George, Git, submitted
Julia, Git, not submitted
Kenny, Shell Navigation, not submitted
James, shell Basics, submitted
Libron, Shell Navigation, not submitted
Michael, Git, not submitted
Jordan, Shell Basics, submitted
EOF

cat > "$App_Dir/startup.sh" << 'EOF'
#!/bin/bash

# Get absolute path of this script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to reminder.sh
reminder_script="$script_dir/app/reminder.sh"

# Check if config file exists
if [ ! -f "$script_dir/config/config.env" ]; then
    echo "Error: config.env not found. Please run this script from inside $script_dir"
    exit 1
fi

# Launch the reminder app
bash "$reminder_script"

EOF

#Give .sh files excecution permissions
chmod +x $app/*
chmod +x $modules/*
cd $App_Dir
chmod +x startup.sh
cd ..


echo "wow! Environment has been created successfully"
echo "To test the application run:"
echo "cd $App_Dir && ./startup.sh"



