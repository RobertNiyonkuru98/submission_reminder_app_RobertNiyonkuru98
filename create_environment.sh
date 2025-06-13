#!/bin/bash

# Ask the user to enter the name

read -p "Enter your directory name: " name

if [ -z "$name" ]; then
	echo "You have to enter the name."
	exit 1
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


[ ! -f "$dir/app/reminder.sh" ] && touch "$dir/app/reminder.sh"
[ ! -f "$dir/modules/functions.sh" ] && touch "$dir/modules/functions.sh"
[ ! -f "$dir/assets/submissions.txt" ] && touch "$dir/assets/submissions.txt"
[ ! -f "$dir/config/config.env" ] && touch "$dir/config/config.env"
[ ! -f "$dir/startup.sh" ] && touch "$dir/startup.sh"

# Adding content to the empty files in the sub-directories

# Appending the content needed in the created empty files

echo '
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
' >> $dir/app/reminder.sh

echo '
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
' >> $dir/modules/functions.sh

echo '
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
' >> $dir/assets/submissions.txt

echo '
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
' >> $dir/config/config.env

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
