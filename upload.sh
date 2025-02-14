#!/bin/bash

# Check if a file argument is provided
if [[ "$#" -eq 0 ]]; then
    echo "ERROR: No file specified. Usage: ./upload.sh <filename>"
    exit 1
fi

# Store the file path, preserving spaces
FILE="$1"

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
    echo "ERROR: File '$FILE' does not exist."
    exit 1
fi

# Query GoFile API to find the best server for upload
echo "Fetching the best server for upload..."
SERVER=$(curl -s https://api.gofile.io/servers | jq -r '.data.servers[0].name')

if [[ -z "$SERVER" ]]; then
    echo "ERROR: Failed to retrieve the server from GoFile API."
    exit 1
fi

echo "Uploading to server: $SERVER..."

# Upload the file to GoFile
UPLOAD_RESPONSE=$(curl -# -F "file=@$FILE" "https://${SERVER}.gofile.io/uploadFile" 2>&1)

# Check if the upload was successful
if [[ $? -ne 0 ]]; then
    echo "ERROR: Failed to upload the file."
    exit 1
fi

# Extract the download page URL from the response
LINK=$(echo "$UPLOAD_RESPONSE" | jq -r '.data.downloadPage')

if [[ -z "$LINK" ]]; then
    echo "ERROR: Failed to extract the download link from the response."
    exit 1
fi

# Display the download link
echo "Upload successful! Download link:"
echo "$LINK"