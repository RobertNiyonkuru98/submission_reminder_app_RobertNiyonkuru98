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
