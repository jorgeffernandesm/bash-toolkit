#!/bin/bash

# This script mounts remote directories using sshfs for specified hostnames.
# If no hostnames are provided as arguments, it uses default hostnames.

# Default values:
# - DEFAULT_HOSTNAMES: Array of default hostnames to connect to.
# - PORT: SSH port to use (default is 22).
# - USER: Username for SSH connection (default is 'jorge').
# - REMOTE_PATH: Remote directory to mount (default is '/').
# - OPTIONS: SSHFS options including allowing other users, default permissions, and disabling strict host key checking.

# Usage:
# ./m [hostname1] [hostname2] ...

# If no arguments are provided, the script uses the default hostnames.
# The script checks if it is running as root and re-executes itself with sudo if necessary.

# For each hostname:
# - It retrieves the corresponding IP address from /etc/hosts.
# - Creates a local directory under /mnt/ for the hostname.
# - Prompts the user for the remote SSH password.
# - Mounts the remote directory to the local directory using sshfs.
# - Lists the contents of the mounted directory.

# Troubleshooting: 
# If sshfs fails due to host identification:
# Automatically removes the offending key using:
# sudo ssh-keygen -f "/root/.ssh/known_hosts" -R <IP>
# Then retries the sshfs mount.
#
# To refresh credentials:
# sudo ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.0.10"
# ssh jorge@192.168.0.10
# try again


# Default values
DEFAULT_HOSTNAMES=("satan" "ukobachW" "belphegor")
PORT=22
USER=jorge
REMOTE_PATH=/
OPTIONS=allow_other,default_permissions,StrictHostKeyChecking=no,uid=1000,gid=1000
#,debug,sshfs_debug,loglevel=debug

# Read hostnames from arguments or use defaults
if [ "$#" -eq 0 ]; then
  HOSTNAMES=("${DEFAULT_HOSTNAMES[@]}")
else
  HOSTNAMES=("$@")
fi

df -h

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Credentials checks:"
  sudo "$0" "$@"
  exit $?
fi

# Iterate through hostnames
for HOSTNAME in "${HOSTNAMES[@]}"; do
  echo -e -n "Continue mounting \e[31m${HOSTNAME}\e[0m ([y]/n)? "
  read CONTINUE
  if [ "$CONTINUE" = "y" ] || [ "$CONTINUE" = "" ]; then
    echo

    echo -n "Enter username for $HOSTNAME ($USER): "
    read INPUT_USER
    if [ -n "$INPUT_USER" ]; then
      USER=$INPUT_USER
    fi

    HOST=$(grep -w $HOSTNAME /etc/hosts | grep -v '^#' | cut -d " " -f 1)
    LOCAL_PATH=/mnt/$HOSTNAME

    if [ -z "$HOST" ]; then
      echo "Error: Hostname '$HOSTNAME' not found in /etc/hosts."
      continue
    fi

    echo "Creating local folder for $HOSTNAME..."
    mkdir -p $LOCAL_PATH
    chown root:root $LOCAL_PATH
    chmod 755 $LOCAL_PATH

    echo -n "Remote $USER@$HOSTNAME ($HOST) password: "
    read -s REMOTE_PASSWORD
    echo

    echo "Mounting remote folder for $HOSTNAME..."
    echo "$REMOTE_PASSWORD" | sshfs -p $PORT -o $OPTIONS -o password_stdin $USER@$HOST:$REMOTE_PATH $LOCAL_PATH 2> /tmp/mount_err.log

    if [ $? -ne 0 ]; then
      if grep -q "REMOTE HOST IDENTIFICATION HAS CHANGED" /tmp/mount_err.log; then
        echo "⚠️ SSH key mismatch detected for $HOST. Attempting automatic fix..."
        ssh-keygen -f "/root/.ssh/known_hosts" -R "$HOST"
        echo "$REMOTE_PASSWORD" | sshfs -p $PORT -o $OPTIONS -o password_stdin $USER@$HOST:$REMOTE_PATH $LOCAL_PATH
      else
        echo "❌ Mount failed for $HOSTNAME. See /tmp/mount_err.log for details."
        continue
      fi
    fi

    echo "Listing $LOCAL_PATH:"
    ls $LOCAL_PATH
  fi
done
