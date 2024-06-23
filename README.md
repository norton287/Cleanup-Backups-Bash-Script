
# clean_backups.sh: Your Backup Cleanup Superhero!

Tired of old backups cluttering your precious storage? Let `clean_backups.sh` swoop in and save the day!

## What it does

- **Finds:** Locates all `.tar.gz` and `.bak` backup files in your specified directory and its subdirectories.
- **Identifies:** Pinpoints backups older than 4 days based on their modification timestamps.
- **Eliminates:** Safely removes these outdated backups to free up disk space.
- **Double-Checks:** Performs a final scan of your entire backup directory to catch any stragglers.

## Why you'll love it

- **Smart & Efficient:** Only targets old backups that match your naming convention.
- **Thorough:** Goes deep into subdirectories and leaves no backup untouched.
- **Secure:** Includes a sanity check for extra peace of mind.
- **Customizable:** Easily adjust the backup directory and age threshold to fit your needs.

## How to use it

1. **Configure:** Set `backup_dir` in the script to your main backup directory.
2. **Execute:** Run `./clean_backups.sh` from your terminal. Make sure to `chmod +x clean_backups.sh` first.
3. **Relax:** Watch as your old backups vanish, leaving your storage sparkling clean!

## Example Usage
```
Bash
./clean_backups.sh
```

## Important Notes
- This script assumes your backup files follow a naming pattern like filename-YYYY-MM-DD-HH-MM-SS.tar.gz or .bak.
- Always double-check your backups before running this script!

## Contribute

- Found a bug or have an idea for improvement? We welcome contributions! Feel free to open an issue or submit a pull request.

## Let's keep those backups tidy! 🚀
