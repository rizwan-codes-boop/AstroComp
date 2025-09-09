#!/bin/bash

# 1. Display path to home directory
echo "Home directory: $HOME"

# Display username
echo "Username: $USER"

# 2. Define a variable called nonsense
nonsense="This is such a nonsense!"

# Print the content of nonsense
echo "$nonsense"

# 3. Redirect nonsense into nonsense.txt and notify
echo "$nonsense" > nonsense.txt
echo "nonsense.txt was just created/overwritten."

# 4. Append modified nonsense (spaces replaced by underscores) to file
echo "${nonsense// /_}" >> nonsense.txt

# 5. Replace "such a" with "not" and append " It's Bash", then append to file
modified="${nonsense//such a/not} It's Bash"
echo "$modified" >> nonsense.txt

# 7. Show home directory with all slashes removed
echo "${HOME//\//}"