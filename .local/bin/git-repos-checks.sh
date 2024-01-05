#!/bin/bash
#
# A comprehensive set of checks for Git repositories within a directory
# structure.

# Function to check if a directory is a git repository
is_git_repo() {
  git -C "$1" rev-parse > /dev/null 2>&1
}

# Check different aspects of the repository state
check_repo_state() {
  local repo_dir="$1"
  local check_type="$2"

  case $check_type in
    "detached_head")
      git -C "$repo_dir" symbolic-ref --quiet HEAD &>/dev/null || return 0  # Detached HEAD
      return 1
      ;;
    "unstaged_changes")
	  [[ $(git -C "$1" status --porcelain | wc -l) -gt 0 ]] && return 0  # Unstaged changes
      return 1
      ;;
    "commits")
      git -C "$repo_dir" rev-parse --verify HEAD &>/dev/null || return 1  # No commits
      return 0
      ;;
    "remote")
	  [[ $(git -C "$repo_dir" remote -v | wc -l) -gt 0 ]] && return 0 || return 1  # Remote
      ;;
    "unpushed_changes")
      if check_repo_state "$repo_dir" "detached_head" \
		  || ! check_repo_state "$repo_dir" "commits" \
		  || ! check_repo_state "$repo_dir" "remote"; then
        return 1  # No commits or no remote (thus, no unpushed changes)
      fi
      local ahead=$(git -C "$repo_dir" rev-list --count --left-right @{u}...HEAD | awk '{print $2}')
      [[ $ahead -gt 0 ]] && return 0 || return 1  # Has unpushed changes
      ;;
    *)
      echo "Invalid check type"
      return 1
      ;;
  esac
}

# Function to recursively search for git repositories and check for changes
check_git_repos() {
  local dir="$1"
  for d in "$dir"/*; do
    if [[ -d $d ]]; then
      if is_git_repo "$d"; then
		! check_repo_state "$d" "remote" && echo "Repository $d does not have a remote"
		! check_repo_state "$d" "commits" && echo "Repository $d does not have any commits"
        check_repo_state "$d" "detached_head" && echo "Repository $d has a detached HEAD"
        check_repo_state "$d" "unstaged_changes" && echo "Repository $d has unstaged changes"
        check_repo_state "$d" "unpushed_changes" && echo "Repository $d has unpushed changes"
      else
        check_git_repos "$d"
      fi
    fi
  done
}

# Check non-git directories
check_non_git_dirs() {
  local dir="$1"
  local has_repo=0
  for d in "$dir"/*; do
    if [[ -d $d ]]; then
      if is_git_repo "$d"; then
        has_repo=1
        break
      else
        check_non_git_dirs "$d"
      fi
    fi
  done
  [[ $has_repo -eq 0 ]] && echo "Directory $dir does not contain a git repository"
}

# Main script
if [[ -z $1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if ! [[ -d $1 ]]; then
  echo "$1 is not a directory"
  exit 1
fi

dir="${1%/}"
check_git_repos "$dir"
check_non_git_dirs "$dir"
