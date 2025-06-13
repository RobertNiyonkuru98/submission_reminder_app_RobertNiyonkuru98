#!/bin/bash

# Asking the user to enter his/her name

read -p "Enter the same name as entered in the environment folder name: " name
dir="submission_reminder_$name"

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
    echo "Invalid input." 
    echo "Assignment must not be empty and days must be a number."
    exit 1
fi

# Update config.env
echo "Updating config.env in $dir/config/"
echo "ASSIGNMENT=\"$Assignment\"" > "$dir/config/config.env"
echo "DAYS_REMAINING=$Days" >> "$dir/config/config.env"

echo "✅ Configuration updated:"
cat "$dir/config/config.env"
