# submission_reminder_app_honnete-1
Summative assessment
Project Overview
The Submission Reminder App is a shell scripting project designed to help automate reminders for students who have not yet submitted their assignments. The project demonstrates how to use Linux commands, shell scripting, and file management automation to create a small but functional application.
It showcases key skills such as:
Creating and managing directory structures programmatically.


Reading and processing files using Bash scripts.


Using environment variables for configuration.


Writing modular and reusable shell functions.


Automating application startup and updates.



Project Structure
When the setup script (create_environment.sh) runs, it automatically generates the following structure:
submission_reminder_{YourName}/
│
├── app/
│   └── reminder.sh
│
├── modules/
│   └── functions.sh
│
├── assets/
│   └── submissions.txt
│
├── config/
│   └── config.env
│
└── startup.sh

Each component in this structure has a specific role in the overall functionality of the app.
How the App Works
1. create_environment.sh
This is the main setup script that builds the entire environment for the application.
 When executed, it:
Prompts the user to enter their name.


Creates a directory called submission_reminder_{name}.


Inside it, creates the subdirectories: app, modules, assets, and config.


Generates and populates all required files (config.env, reminder.sh, functions.sh, submissions.txt, and startup.sh) with predefined content.


Automatically grants execute permissions (chmod +x) to all .sh files.


Displays a success message and instructions for running the application.
Purpose: Automates environment creation and prepares the application for immediate use.
2. config.env
Located in# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2

 the config directory, this file stores configuration values used by the application.
Purpose:
Defines environment variables like the current assignment and remaining days for submission.


Makes the app flexible — you can modify these values without touching the main code.



3. submissions.txt
Located in the assets directory, this text file stores the list of students and their submission status.
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
...
Purpose:
Serves as the data source for the reminder system.


The script scans this file to identify which students haven’t submitted their assignments.



4. functions.sh
Stored under the modules directory, this file contains reusable functions used by the main app logic.
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
Purpose:
Defines check_submissions(), which reads the submissions.txt file.


Filters out students who have not submitted the assignment specified in config.env.


Displays personalized reminders for each pending student.



5. reminder.sh
Located in the app folder, this is the core execution script for the app.
#!/bin/bash
source ./config/config.env
source ./modules/functions.sh
submissions_file="$(dirname "$0")/../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
Purpose:
Loads environment variables and helper functions.


Displays assignment details and remaining days.


Calls the check_submissions function to print reminders.



6. startup.sh
This is the launcher script that runs the app easily from one command.
#!/bin/bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
reminder_script="$script_dir/app/reminder.sh"

if [ ! -f "$script_dir/config/config.env" ]; then
    echo "Error: config.env not found."
    exit 1
fi

bash "$reminder_script"
Purpose:
Ensures that configuration files exist.


Starts the reminder application.


Makes testing and usage simple by allowing a single command:
Purpose:
Makes the app interactive and flexible for checking multiple assignments dynamically.
 How to Run the Application
Step 1: Make the setup script executable
chmod +x create_environment.sh

Step 2: Create the environment
./create_environment.sh

When prompted, enter your name.
This will generate the directory submission_reminder_{YourName} and all required files.
cd submission_reminder_{YourName}
./startup.sh
Step 3: Run the application
cd submission_reminder_{YourName}
./startup.sh
The app will display:
The current assignment.


Days remaining.


Students who haven’t submitted yet.
Step 4: Use the Copilot script to check another assignment
./copilot_shell_script.sh
Enter the new assignment name (e.g., “Git”) to ensure all .sh files are executable.


Run the app from inside the generated directory.


You can extend the functionality by adding more students or assignments.


The project demonstrates practical automation, scripting logic, and system design principles using Linux Shell.
eck pending submissions for that one.









