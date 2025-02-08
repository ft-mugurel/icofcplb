# icofcplb

**icofcplb** stands for "In Case of Fire: Git Commit, Git Push, Then Leave the Building."

A simple script that scans all directories containing Git repositories and checks for uncommitted, untracked, or unpushed changes. The program then lists these repositories for easy tracking and management.

## Features
- Recursively scans specified directories for Git repositories.
- Checks for:
  - Uncommitted changes
  - Untracked files
  - Unpushed commits
- Displays a summary of repositories with pending changes.

## Installation
Ensure you have Git installed on your system. Clone this repository and navigate into the directory:

```sh
# Clone the repository
git clone <repository-url>
cd icofcplb

# Make the script executable
chmod +x icofcplb.sh
```

## Usage
Run the script to scan for repositories with pending changes:

```sh
./icofcplb.sh /path/to/search
```

If no directory is specified, the default path `$HOME/mtu` will be used:

```sh
./icofcplb.sh
```

To see the help message:

```sh
./icofcplb.sh --help
```

The script will output a list of repositories that have:
- Uncommitted changes (files modified but not staged or committed)
- Untracked files (new files not yet added to the repository)
- Unpushed commits (committed locally but not pushed to the remote repository)

## Example Output
```sh
 -------------- in repo1 --------------
modified: file1.txt
untracked: file2.txt

 -------------- in repo2 --------------
Unpushed commits in repo2:
- commit1
- commit2

 -------------- in repo3 --------------
added: file3.txt
deleted: file4.txt

Done. Found 3 repositories with pending changes.
```

## Adding to Shell Path
To make the script accessible from anywhere in your terminal, you can add it to your shell's PATH. Add the following line to your `.bashrc`, `.zshrc`, or corresponding shell configuration file:

```sh
export PATH=$PATH:/path/to/icofcplb
```

After adding this line, reload your shell configuration:

```sh
source ~/.bashrc  # or source ~/.zshrc
```

Now you can run the script from anywhere:

```sh
icofcplb.sh /path/to/search
```

## Requirements
- Git
- Bash

## Future Improvements
- Add support for ignoring specific repositories.
- Provide an interactive mode for committing and pushing changes.
- Export the report in JSON or Markdown format.

## License
This project is licensed under the MIT License.

## Contributions
Contributions are welcome! Feel free to fork the repository and submit a pull request.
```
