Submission Reminder App

This is a Bash-based system to help track which students have submitted their given assignments and which ones didn't. This app helps teachers and students to set reminders, monitor submissions and run checks from the terminal.

The app:
1. Creates the environment folder containing needed resources
2. It tracks the submissions of the assignments
3. It notifies which students haven't submitted
4. It lets you decide/configure which assignment to track
5. It runs a reminder script to show pending submissions

To get started:

1. Download the project or use git clone 
2. Set up your environment by running 'create_environment.sh':
    a. You will be asked to enter your name
    b. It will create a folder that contains your name in it (submission_reminder_your name) which contains all files and folders needed.
3. Configure the assignment to track by running 'copilot_shell_script.sh':
    a. You will be asked a folder to checkup and which assignment to track (Git, Shell Navigation, etc)
    b. You will be asked how many days left till submission
4. Start of the Reminder App
    normally the app will start during setup but if not run it like this
        ./submission_reminder_<YourName>/startup.sh:
    The app will:
        Read the entered assignment
        Search submissions.txt for students who haven't submitted
        Print reminders in the terminal


Rules:

1. Entered names (of a user) must contain only letters and spaces
2. Entered Assignment names must be letters/spaces (e.g., Shell Basics)
3. Days remaining must be numerical
4. Assignment name must be existing already inside submissions.txt

CREDITS
Built for Bash Learners
Author: [Robert Tony MITALI NIYONKURU]
Version: 11.0
