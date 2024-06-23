#!/bin/bash

backup_dir="/backup"  # Root backup directory
current_time=$(date +%s)  # Get current time in seconds since epoch

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
    file_name="$1"
    if [[ "$file_name" =~ ^.*-[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}\.(tar\.gz|bak)$ ]]; then
        return 0  # File name matches pattern
    else
        return 1  # File name doesn't match pattern
    fi
}

# Traverse subdirectories for initial cleanup
find "$backup_dir" -type f \( -name "*.tar.gz" -o -name "*.bak" \) | while read -r file_path; do
    file_name=$(basename "$file_path")
    if is_old_file "$file_path" && matches_pattern "$file_name"; then
        echo "Removing: $file_path"
        rm "$file_path"
    fi
done

# Final sanity check: Remove ANY file older than 4 days in the entire directory
find "$backup_dir" -type f -mtime +4 -exec rm {} \; 
