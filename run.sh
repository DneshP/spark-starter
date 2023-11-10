#!/bin/bash

# Start Docker containers
docker-compose up -d

# Retrieve the Jupyter notebook access token from the container logs
notebook_url=$(docker logs spark-notebook 2>&1 | awk '/token=/{print $NF; exit}' | sed 's/http:\/\/[0-9a-f]\{12\}:8888/http:\/\/localhost:9100/')
echo "Open your browser and navigate to $notebook_url with the token to access Jupyter notebooks."

# Alternatively, you can open the default browser automatically
# xdg-open "http://localhost:9100/?token=$access_token"  # Uncomment this line for Linux
# open "http://localhost:9100/?token=$access_token"      # Uncomment this line for macOS
# start "http://localhost:9100/?token=$access_token"     # Uncomment this line for Windows
