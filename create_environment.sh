#!/bin/bash

# Ask the user to enter the name
echo "The directory has to have a name"
read -p "Please,Enter your directory name: " name

# Creating the folder

dir="submission_reminder_$name"
mkdir -p "$dir"

# Creating subdirectories and files

mkdir -p "$dir/app"
mkdir -p "$dir/modules"
mkdir -p "$dir/assets"
mkdir -p "$dir/config"
mv reminder.sh "$dir/app/"
mv functions.sh "$dir/modules"
mv submissions.txt "$dir/assets"
mv config.env "$dir/config"
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
