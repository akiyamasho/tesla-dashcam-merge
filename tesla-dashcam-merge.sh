#!/bin/bash

MERGE_GRID=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --merge-grid) MERGE_GRID=true;;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

# Check if ffmpeg is installed
if ! [ -x "$(command -v ffmpeg)" ]; then
      echo "ffmpeg not found. Installing via Homebrew.."
      brew install ffmpeg
fi

# 1. Put all files with these specific suffixes in their own category folder
suffixes=("back.mp4" "front.mp4" "left_repeater.mp4" "right_repeater.mp4")

for suffix in "${suffixes[@]}"; do
    dir="${suffix%.*}"
    mkdir -p "$dir"
    for file in *"$suffix"; do
        mv "$file" "$dir"
    done
done

# 2. For each of the 4 folders, merge the videos inside sorted by name, into a single file using ffmpeg
for dir in "${suffixes[@]}"; do
    dir="${dir%.*}"
    cd "$dir" || exit
    for file in *.mp4; do
        echo "$file"
    done > files.txt
    while read -r line; do
        echo "file '$line'" >> ffmpeglist.txt
    done < files.txt
    ffmpeg -f concat -safe 0 -i ffmpeglist.txt -c copy "../$dir.mp4"
    rm files.txt ffmpeglist.txt
    cd .. || exit
done

# 3. Merge the output videos into a single grid layout video
# Only run this block if --merge-grid was specified
if $MERGE_GRID; then
    ffmpeg -i front.mp4 -i back.mp4 -i left_repeater.mp4 -i right_repeater.mp4 \
    -filter_complex "\
    [0:v]scale=724:369,setpts=PTS-STARTPTS[front]; \
    [1:v]scale=724:369,setpts=PTS-STARTPTS[back]; \
    [2:v]scale=724:369,setpts=PTS-STARTPTS[left]; \
    [3:v]scale=724:369,setpts=PTS-STARTPTS[right]; \
    [front][back]hstack=inputs=2[top]; \
    [left][right]hstack=inputs=2[bottom]; \
    [top][bottom]vstack=inputs=2[v]" \
    -map "[v]" merged_output.mp4
fi