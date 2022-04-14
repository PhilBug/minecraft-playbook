#!/usr/bin/env bash

set -e

DATE=$(date +%Y-%m-%d)
BACKUP_FILE_NAME="minecraft-backup-$DATE.tgz"
MINECRAFT_WORLD_DIR="/opt/minecraft" # {{ minecraft_dir }}
BUCKET_NAME="kwadratowekarpicko" # {{ minecraft_backup_bucket }}

function log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1"
}

function stop_minecraft() {
    log "Stopping Minecraft server"
    docker stop minecraft_server
}

function start_minecraft() {
    log "Start Minecraft server"
    docker start minecraft_server
}

function create_backup() {
    cd $MINECRAFT_WORLD_DIR || exit 1
    log "Creating backup..."
    tar -czvf "$BACKUP_FILE_NAME" "data/"
    log "Backup created."
}

function upload_backup_to_bucket() {
    log "Uploading backup to bucket..."
    aws s3 cp "$MINECRAFT_WORLD_DIR/$BACKUP_FILE_NAME" "s3://$BUCKET_NAME/$BACKUP_FILE_NAME"
    log "Backup uploaded."
    rm -vf "$MINECRAFT_WORLD_DIR/$BACKUP_FILE_NAME"
    log "Local backup removed."
}

function remove_s3_backups_older_than_n_days() {
    RETENTION_DAYS=45
    log "Removing backups older than $RETENTION_DAYS days..."
    aws s3 ls "s3://$BUCKET_NAME/" | \
        grep -v "^d" | \
        awk '{print $4}' | \
        sort -r | \
        tail -n +$RETENTION_DAYS | \
        xargs -I {} aws s3 rm "s3://$BUCKET_NAME/{}"
    log "Backups older than $RETENTION_DAYS days removed."
}

stop_minecraft && sleep 5
create_backup
start_minecraft && sleep 5
upload_backup_to_bucket
remove_s3_backups_older_than_n_days 45
