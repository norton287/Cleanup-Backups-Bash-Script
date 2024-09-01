#!/bin/bash

backup_dir="/share"
exclude_dir="/share/ftl"
current_time=$(date +%s)  # Get current time in seconds since epoch
log_file="/var/log/spindlecrank/cleanup.log"

# Check for log file and create if needed
if [ ! -f "$log_file" ]; then
    mkdir -p "$(dirname "$log_file")"
    touch "$log_file"
fi

# Function for logging
log() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$log_file"
}

# Function to rotate and clean up logs
rotate_logs() {
    if [ -f "$log_file" ] && [ $(stat -c%s "$log_file") -ge 1048576 ]; then # 1 MB
        mv "$log_file" "${log_file}-$(date +'%Y%m%d_%H%M%S').bak"
        find "$(dirname "$log_file")" -name "*.bak" -mtime +6 -delete
    fi
}

# Function to check file age (now in seconds)
is_old_file() {
    file_path="$1"
    file_mtime=$(stat -c %Y "$file_path")  # Get file modification time in seconds
    file_age_seconds=$((current_time - file_mtime))
    if [[ $file_age_seconds -gt $((4 * 24 * 60 * 60)) ]]; then  # Older than 4 days?
        return 0  # File is old
    else
        return 1  # File is not old
    fi
}

# Function to check file name format (now handles .bak too)
matches_pattern() {
    local file_name="$1"
    if [[ "$file_name" =~ ^.*-[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}\.(tar\.gz|bak)$ ]]; then
        return 0  # File name matches pattern
    else
        return 1  # File name doesn't match pattern
    fi
}

# Main script logic
rotate_logs  # Rotate logs at the start
log "Backup cleanup script started."

# Traverse subdirectories, excluding the specified directory and filtering by extensions
find "$backup_dir" -type f \( -name "*.gz" -o -name "*.bak" -o -name "*.tar" -o -name "*.zip" \) -not -path "$exclude_dir/*" | while read -r file_path; do
    file_name=$(basename "$file_path")
    if is_old_file "$file_path"; then
        log "Removing: $file_path"
        rm "$file_path"
    fi
done

log "Backup cleanup script finished."
