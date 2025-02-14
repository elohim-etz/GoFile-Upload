# GoFile Upload Script

This is a simple Bash script to upload files to [GoFile](https://gofile.io/) directly from the command line. The script automatically selects the best server for upload and returns the download link.

## Features
- Automatically fetches the best GoFile server for upload.
- Supports uploading a single file.
- Displays a progress bar during the upload.
- Returns the download link upon successful upload.

## Prerequisites
- **Bash**: The script is written for Bash and should work on most Unix-like systems (Linux, macOS).
- **curl**: Used to interact with the GoFile API and upload files.
- **jq**: Used to parse JSON responses from the GoFile API.

## Usage
```
curl -sSL https://raw.githubusercontent.com/elohim-etz/GoFile-Upload/main/upload.sh | bash -s -- ./filename
```