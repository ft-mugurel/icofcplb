# icofcplb

**icofcplb** stands for "In Case of Fire: Git Commit, Git Push, Then Leave the Building."

A simple script that scans all directories containing Git repositories and checks for uncommitted or unpushed changes. The program then lists these repositories for easy tracking and management.

## Features
- Recursively scans specified directories for Git repositories.
- Checks for:
  - Uncommitted changes
  - Unpushed commits
- Displays a summary of repositories with pending changes.

## Installation
Ensure you have Git installed on your system. Clone this repository and navigate into the directory:

```sh
# Clone the repository
git clone <repository-url>
cd icofcplb

# Make the script executable (if applicable)
chmod +x git-checker.sh
```

## Usage
Run the script to scan for repositories with pending changes:

```sh
./git-checker.sh /path/to/search
```

or, if implemented in Python:

```sh
python3 git-checker.py /path/to/search
```

The script will output a list of repositories that have:
- Uncommitted changes (files modified but not staged or committed)
- Unpushed commits (committed locally but not pushed to the remote repository)

## Example Output
```
Checking repositories in /home/user/projects...

Repository: /home/user/projects/repo1
 - Uncommitted changes
 - Unpushed commits

Repository: /home/user/projects/repo2
 - Uncommitted changes

Done. Found 2 repositories with pending changes.
```

## Requirements
- Git
- Bash (for shell script) or Python (for Python script)

## Future Improvements
- Add support for ignoring specific repositories.
- Provide an interactive mode for committing and pushing changes.
- Export the report in JSON or Markdown format.

## License
This project is licensed under the MIT License.

## Contributions
Contributions are welcome! Feel free to fork the repository and submit a pull request.
