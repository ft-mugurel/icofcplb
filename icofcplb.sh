#!/bin/bash

# Function to search for .git directories recursively
search_git_dirs() {
    local dir="$1"
    find "$dir" -type d -name ".git" 2>/dev/null | while read -r gitdir; do
        local repo_dir
        repo_dir=$(dirname "$gitdir")
        status_output=$(cd "$repo_dir" && git status --porcelain)
        if [ -n "$status_output" ]; then
            echo -e "\033[1;34mFound .git directory in: $repo_dir\033[0m"
            echo -e "\033[1;32mRunning 'git status' in $repo_dir\033[0m"
            while IFS= read -r line; do
                status_code=$(echo "$line" | cut -c1-2)
                file_path=$(echo "$line" | cut -c4-)
                case "$status_code" in
                    '??') status_desc="untracked" ;;
                    'M ') status_desc="modified" ;;
                    'A ') status_desc="added" ;;
                    'D ') status_desc="deleted" ;;
                    'R ') status_desc="renamed" ;;
                    'C ') status_desc="copied" ;;
                    'UU') status_desc="unmerged" ;;
                    *) status_desc="unknown" ;;
                esac
                echo "$status_desc: $file_path"
            done <<< "$status_output"
            echo -e "\033[0m"  # Reset color
        fi
    done
}

# Check if at least one directory is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory1> [<directory2> ...]"
    exit 1
fi

# Iterate over all provided directories
for dir in "$@"; do
    if [ -d "$dir" ]; then
        search_git_dirs "$dir"
    else
        echo "Directory $dir does not exist."
    fi
done

