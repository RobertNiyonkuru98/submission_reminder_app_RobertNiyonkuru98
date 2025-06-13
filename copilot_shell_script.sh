#!/bin/bash

# Asking the user to enter his/her name

read -p "Enter the same name as entered in the environment folder name: " name
dir="submission_reminder_$name"
submissions_file="$dir/assets/submissions.txt"

# Checking if the directory exists
if [ ! -d "$dir" ]; then
	echo "Directory '$dir' not found"
	echo "Please run create_environment.sh."
	exit 1
fi

# Prompt for the assignment and the days remaining
read -p "Enter the name for the assignment: " Assignment
read -p "Enter the number of days remaining for submission: " Days

# Input validation


if [ -z "$Assignment" ] || ! [[ "$Days" =~ ^[0-9]+$ ]]; then
    echo "The Assignment name cannot be empty and the Days have to be numbers."
    exit 1
fi

if ! [[ "$Assignment" =~ ^[a-zA-Z\s]+$ ]]; then
    echo "The Assignment name must contain only letters and spaces."
    exit 1
fi

# Step 3: Check if the assignment exists in submissions.txt
if ! grep -iq ", *$Assignment," "$submissions_file"; then
    echo "Assignment '$Assignment' not found in submissions.txt"
    exit 1
fi
# Update config.env
echo "Updating config.env in $dir/config/"
echo "ASSIGNMENT=\"$Assignment\"" > "$dir/config/config.env"
echo "DAYS_REMAINING=$Days" >> "$dir/config/config.env"

echo "Configuration updated:"
cat "$dir/config/config.env"

# Ask if they want to start the app
read -p "Would you like to run the reminder app now? (y/n): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Starting the app..."
    bash "$dir/startup.sh"
else
    echo "Reminder app not started. You can run it later using: bash $dir/startup.sh"
fi
