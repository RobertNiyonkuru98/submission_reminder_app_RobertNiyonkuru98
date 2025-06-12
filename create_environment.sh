#!/bin/bash

# Ask the user to enter the name

read -p "Enter your directory name: " name

if [ -z "$name" ]; then
	echo "You have to enter the name."
	continue
fi

# Creating the folder

dir="submission_reminder_$name"

if [ -d "$dir" ]; then
	echo "Directory already exists"
	exit 1
else
	mkdir -p "$dir"
	echo "The directory was created"
fi


# Creating subdirectories and files
mkdir -p "$dir/app"
mkdir -p "$dir/modules"
mkdir -p "$dir/assets"
mkdir -p "$dir/config"


[ ! -f "$dir/app/reminder.sh" ] && cp reminder.sh "$dir/app/"
[ ! -f "$dir/modules/functions.sh" ] && cp functions.sh "$dir/modules"
[ ! -f "$dir/assets/submissions.txt" ] && cp submissions.txt "$dir/assets"
[ ! -f "$dir/config/config.env" ] && cp config.env "$dir/config"
touch $dir/startup.sh

# Making them executable

chmod +x "$dir/app/reminder.sh"
chmod +x "$dir/modules/functions.sh"
chmod +x "$dir/assets/submissions.txt"
chmod +x "$dir/config/config.env"
chmod +x "$dir/startup.sh"

# Tell the user that we're done

echo "The setup is complete."
echo "You can check: $dir"
