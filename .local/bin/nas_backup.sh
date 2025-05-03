#!/bin/bash

# NAS Local Backup Script from NAS to backup on local computer
# place somewhere in $PATH (for example $HOME/.local/bin)
# give execute permissions
#
# Usage:
#       $ nas_backup.sh -home : backup NAS Home
#       $ nas_backup.sh -notes: backup notes only

# Set directories to backup
NAS_DIR=/media/NAS_Home/
BACKUP_DIR=/media/HDD_WD500/Libraries/NAS_Offline/

function usage () {
    printf "Usage:\n"
    printf "\tnas_backup.sh -home: backup NAS Home\n"
    printf "\tnas_backup.sh -notes: backup notes only\n"
}

if [[ $# -lt 1 ]] ; then
    usage
elif [[ $1 = "-home" ]] ; then
    rsync -auP --exclude=@Recycle --exclude=Backups/linux_mint_home $NAS_DIR $BACKUP_DIR
    echo "NAS Home backup complete"
elif [[ $1 = "-notes" ]] ; then
    NAS_NOTES_DIR="${NAS_DIR}mdnotes/"
    BACKUP_NOTES_DIR="${BACKUP_DIR}mdnotes/"
    echo "Backing up mdnotes..."
    rsync -au $NAS_NOTES_DIR $BACKUP_NOTES_DIR
    echo "done!"
else
    printf "Invalid arguments\n"
    usage
fi
