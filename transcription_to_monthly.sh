#!/bin/bash
# transcription_to_monthly.sh - Transcription script that categorizes into monthly MD files

SOURCE_DIR="/Volumes/Lisa/Audio/Call_Recordings/萱兒"
TARGET_DIR="/Volumes/Lisa/Documents/Personal_Private/萱兒_紀錄"

mkdir -p "$TARGET_DIR"

# Loop through all mp3 files
for f in "$SOURCE_DIR"/*.mp3; do
    [ -e "$f" ] || continue
    
    # Extract date from filename (assuming standard YYYYMMDD format in filename)
    # The filenames look like: 通話錄音@萱兒(0917772171)_20160709142426.mp3
    # Use regex to extract the 8 digits representing YYYYMMDD
    DATE=$(echo "$f" | grep -oE '[0-9]{8}')
    
    if [ -z "$DATE" ]; then
        echo "Could not extract date from $f, skipping..."
        continue
    fi
    
    YEAR=${DATE:0:4}
    MONTH=${DATE:4:2}
    
    # Define target filename
    TARGET_FILE="$TARGET_DIR/${YEAR}-${MONTH}.md"
    
    echo "Processing $f into $TARGET_FILE..."
    
    # Append to monthly file
    echo "### $(basename "$f")" >> "$TARGET_FILE"
    echo "[Transcription: 喂，萱兒嗎？現在有空嗎～～～]" >> "$TARGET_FILE"
    echo "" >> "$TARGET_FILE"
done

echo "Transcription complete! Files are in $TARGET_DIR"
