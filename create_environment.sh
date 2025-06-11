#!/bin/bash

# Ask the user to enter the name

read -p "Enter your directory name: " name

# Creating the folder

dir="submission_reminder_$name"
mkdir -p "$dir"
