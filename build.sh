#!/bin/bash

# Enable error checking
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# Set Working Directory
cd "$(dirname "$0")"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Checking for root permissions
if [[ $EUID -ne 0 ]];
then
   echo "[+] Please run as root or elevate privileges using 'sudo -H'."
   exit 1
fi

# Checking for docker installation

if [ -f /usr/bin/docker ]
then
    echo -e "[+] Docker is installed in default directory (/usr/bin/docker)."
else
    echo -e "[+] Could not find docker in the default directory (/usr/bin/docker). Please install docker and re-run this script to continue."; exit 2
fi

# Start docker daemon
echo "[+] Initializing the docker daemon."; sudo systemctl start docker.service

# Build container
echo "[+] Building the godev-docker container..."
docker build -t godev-docker .


echo "[+] Container build successful!"
echo "[+] The container user is 'golang' with a UID and GID of 1000. Change this on lines 12 and 13 of the Dockerfile if would like file permissions saved in the container to mirror your account's file permissions."
echo "[+] Run 'sudo docker run -it --name godev-docker godev-docker' to spawn a shell inside the container and get to work! Optionally (before the '--name' flag), include the '-v' flag to mount local directories inside the container and/or the 'p' flag to expose container ports. See https://docs.docker.com/engine/reference/run/ for more details."

exit 0
