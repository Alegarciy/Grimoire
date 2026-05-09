# Taskwarrior Binary, Data Location, and Executable Scope

## Context

This note records a short investigation into where Taskwarrior is installed, where its data lives, and how to think about executables in `/usr/bin` versus project-local code.

Date: 2026-05-04

## Findings

### 1. Taskwarrior program location

Taskwarrior is installed as a system executable at:

- `/usr/bin/task`

This is the command binary that the shell runs when invoking `task`.

### 2. Taskwarrior configuration and data

After re-checking the system once Taskwarrior had been initialized, the following locations were confirmed:

- Config file: `/home/gandalf/.taskrc`
- Data directory: `/home/gandalf/.task`
- Database file: `/home/gandalf/.task/taskchampion.sqlite3`

Taskwarrior also reported:

- `data.location = /home/gandalf/.task`

So the executable is separate from the user data.

### 3. Why the binary is in `/usr/bin` and not in a project like `kairo`

`/usr/bin/task` is not project code or project data. It is the installed program itself.

The distinction is:

- `/usr/bin/task` = installed executable
- `~/.task/` = Taskwarrior user data
- `~/kairo/` or another repo = project files

This means Taskwarrior is available globally on the system rather than belonging to one repository.

### 4. Whether the binary can be edited directly

A file like `/usr/bin/task` is the compiled executable, not the source repository. In normal contribution workflows, one does not edit that installed binary directly.

Instead, contribution happens by:

1. locating the upstream source repository
2. forking it
3. cloning the fork
4. editing source code there
5. building and testing locally
6. opening a pull request

So yes: if the goal is to contribute to Taskwarrior, the right path is to work from a source repository rather than from `/usr/bin/task`.

### 5. Whether being in `/usr/bin` means it is already executable

Yes. Because `task` is installed in `/usr/bin`, it is already a system-level executable and is already available through the shell `PATH`.

That means there is no need to:

- make it executable manually
- turn it into a bash script
- add a shebang
- move it into another folder to run it

You can simply run:

- `task`

### 6. Difference between `/usr/bin`, `/usr/local/bin`, and project-local executables

#### `/usr/bin`

Used for system-managed executables, often installed by the OS package manager.

Examples:

- `/usr/bin/task`
- `/usr/bin/git`

#### `/usr/local/bin`

Used for manually installed or custom global executables.

Examples:

- custom scripts installed by the user
- software installed outside the package manager

#### project-local executables

Used for tools tied to a specific project.

Examples:

- `./node_modules/.bin/...`
- `./venv/bin/python`
- `./scripts/deploy.sh`

These are usually run through a relative path or via a project tool like `npm run`, `npx`, or `poetry run`.

### 7. Scripts versus binaries

A command can be either:

- a binary: compiled machine code
- a script: a text file interpreted by another program

`/usr/bin/task` is a binary, not a shell script.

Scripts created manually usually need:

- a shebang
- execute permission via `chmod +x`

Installed binaries in `/usr/bin` generally do not require any of that from the user.

## Summary

The key conceptual separation is:

- executable program: `/usr/bin/task`
- Taskwarrior user data: `~/.task/taskchampion.sqlite3`
- editable contribution source: a separate git repository

So the presence of `task` in `/usr/bin` means it is already installed system-wide and executable. If contribution is desired, the proper workflow is to work from the source repository, not from the installed binary.
