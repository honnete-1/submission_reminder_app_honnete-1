#!/bin/bash

origin="submission_reminder_*/"
startup="startup.sh"
configuration="./submission_reminder_*/config/config.env"
continu="y"
assignment_name="" # Initialize the variable to hold the user's choice

copilot_function() {
    # The assignment name is passed as the first argument
    assignment="$1"

    if [ ! -d $origin ]; then

        echo "The directory doesn't exist. Please run the file create_environment.sh"
        echo " "
        exit 1
    else
        sed -i "s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$assignment_name\"/" $configuration

        echo "Processing '$assignment' assignment"


        cd $origin
        if [ ! -f $startup ]; then
            echo "Error: $startup not found."
            exit 1
        else
            ./$startup
            cd ..
        fi
    fi
}

while [[ "$continu" == "y" || "$continu" == "Y" ]]; do
    echo " "
    echo "Which assignment do you want to check?"
    echo "Example options:
Shell Navigation
Shell Basics
Git"


    # Read the assignment name directly into assignment_name
    read -p "Enter the assignment name: " assignment_name

    # Call the function, passing the name the user typed
    copilot_function "$assignment_name"

    echo " "
    read -p "Do you want to analyze another assignment (y/n): " continu
done

echo -e "Exiting"
