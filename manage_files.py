import argparse
import os
import subprocess
import sys


# map location in repo to deploy path (relative to home directory)
path_mappings = {
    ".bashrc": ".bashrc",
    ".bash_aliases": ".bash_aliases",
    "init.vim": ".config/nvim/init.vim",
    "go.vim": ".config/nvim/go.vim",
    ".inputrc": ".inputrc",
    ".ssh_config": ".ssh/config",
    "tmux_base.yaml": ".tmuxp/base.yaml",
    ".tmux.conf": ".tmux.conf",
    ".vimrc": ".vimrc",
}


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "command",
        type=str,
        choices=["list", "compare", "backup", "deploy"],
        help="command to run",
    )
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="flag to override limits on running commands with uncomitted changes",
    )
    args = parser.parse_args()

    return args


def get_gh_fullpath(filename):
    return os.path.join(os.environ["HOME"], ".dotfiles", filename)


def get_system_fullpath(filepath):
    return os.path.join(os.environ["HOME"], filepath)


def warn_uncommitted_changes(force):
    """
    Run bash command
        git status | grep modified | awk '{print $2}'
    which gets the current status of the git repo, checks for modified files, and prints just the filename

    If any output is found, output a warning; only continue processing if the force arg was submitted
    """
    output = subprocess.run(["git", "status"], capture_output=True, text=True,)
    if "modified" in output.stdout or "Untracked" in output.stdout:
        print("Warning: repository has uncommitted changes:\n")
        print("-----------------------------------------------------------------------")
        print(f"{output.stdout}")
        print("-----------------------------------------------------------------------")
        if not force:
            print("\nRun with -f to override")
            sys.exit(1)


def compare(args):
    warn_uncommitted_changes(args.force)

    for gh_file, system_path in path_mappings.items():
        command = ["diff", get_gh_fullpath(gh_file), get_system_fullpath(system_path)]
        print(" ".join(command))
        output = subprocess.run(command, capture_output=True, text=True)
        if output.stderr:
            print(f"Error running command: {output.stderr}")
        elif output.stdout:
            print(output.stdout)


def deploy(args):
    warn_uncommitted_changes(args.force)

    for gh_file, system_path in path_mappings.items():
        command = [
            "cp",
            get_system_fullpath(system_path),
            f"{get_system_fullpath(system_path)}.bak",
        ]
        print(" ".join(command))
        output = subprocess.run(command, capture_output=True, text=True)
        if output.stderr:
            print(f"Error running command: {output.stderr}")
            continue
        command = ["cp", get_gh_fullpath(gh_file), get_system_fullpath(system_path)]
        print(" ".join(command))
        output = subprocess.run(command, capture_output=True, text=True)
        if output.stderr:
            print(f"Error running command: {output.stderr}")
        elif output.stdout:
            print(output.stdout)


def backup(args):
    warn_uncommitted_changes(args.force)

    for gh_file, system_path in path_mappings.items():
        command = ["cp", get_system_fullpath(system_path), get_gh_fullpath(gh_file)]
        print(" ".join(command))
        output = subprocess.run(command, capture_output=True, text=True)
        if output.stderr:
            print(f"Error running command: {output.stderr}")
        elif output.stdout:
            print(output.stdout)


def list_mappings(args):
    for gh_file, system_path in path_mappings.items():
        print(f"{get_gh_fullpath(gh_file)} -> {get_system_fullpath(system_path)}")


def main():
    args = parse_args()

    if args.command == "compare":
        compare(args)
    elif args.command == "deploy":
        deploy(args)
    elif args.command == "backup":
        backup(args)
    elif args.command == "list":
        list_mappings(args)


if __name__ == "__main__":
    main()
