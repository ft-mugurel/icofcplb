#!/bin/bash

# Define the default path to search
DEFAULT_SEARCH_PATH="$HOME/MTU"

# Function to search for .git directories recursively
search_git_dirs() {
    local dir="$1"
    find "$dir" -type d -name ".git" 2>/dev/null | while read -r gitdir; do
        local repo_dir
        repo_dir=$(dirname "$gitdir")
        status_output=$(cd "$repo_dir" && git status --porcelain)
        if [ -n "$status_output" ]; then
            repo_name=$(basename "$repo_dir")
            echo -e "\033[1;32m -------------- in $repo_name --------------\033[0m"
            # Check if there are any modified or similar files
            has_changes=false
            while IFS= read -r line; do
                index_status=$(echo "$line" | cut -c1)
                worktree_status=$(echo "$line" | cut -c2)
                file_path=$(echo "$line" | cut -c4-)
                case "$index_status$worktree_status" in
                    '??') status_desc="untracked"; has_changes=true ;;
                    'M ') status_desc="added"; has_changes=true ;;
                    ' M' | 'MM') status_desc="modified"; has_changes=true ;;
                    'D ' | ' D' | 'DM') status_desc="deleted"; has_changes=true ;;
                    'R ' | ' R' | 'RM') status_desc="renamed"; has_changes=true ;;
                    'C ' | ' C' | 'CM') status_desc="copied"; has_changes=true ;;
                    'UU') status_desc="unmerged"; has_changes=true ;;
                    *) status_desc="unknown" ;;
                esac
                echo "$status_desc: $file_path"
            done <<< "$status_output"

            # If there are no changes, check for unpushed commits
            if [ "$has_changes" = false ]; then
                echo -e "\033[1;33mUnpushed commits in $repo_name:\033[0m"
                (cd "$repo_dir" && git cherry -v)
            fi

            echo -e "\033[0m"  # Reset color
        fi
    done
}

# Check for --help argument
if [[ "$1" == "--help" ]]; then
    echo "Usage: $0 [directory]"
    echo "If no directory is specified, the default path $DEFAULT_SEARCH_PATH will be used."
    exit 0
fi

# Determine the path to search
SEARCH_PATH="${1:-$DEFAULT_SEARCH_PATH}"

# Check if the directory exists
if [ -d "$SEARCH_PATH" ]; then
    search_git_dirs "$SEARCH_PATH"
else
    echo "Directory $SEARCH_PATH does not exist."
    exit 1
fi

