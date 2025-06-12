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

# Adding contents in startup.sh

cat <<EOL >> "$dir/assets/submissions.txt"
Robert, Git, not submitted
Tony, Shell Navigation, submitted
Oleg, Git, not submitted
Scott, Shell Basics, not submitted
Audrey, Shell Navigation, submitted
EOL

# Create startup.sh with logic to run the app

cat << 'EOL' > "$dir/startup.sh"
#!/bin/bash
# Startup script for Submission Reminder App

source ./config/config.env
source ./modules/functions.sh
bash ./app/reminder.sh
EOL

# Making them executable

chmod +x "$dir/app/reminder.sh"
chmod +x "$dir/modules/functions.sh"
chmod +x "$dir/assets/submissions.txt"
chmod +x "$dir/config/config.env"
chmod +x "$dir/startup.sh"

# Tell the user that we're done

echo "The setup is complete."
echo "You can check: $dir"
