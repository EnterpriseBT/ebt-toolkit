#!/bin/bash

# Simple Bash CLI Library for Commit Management

# Color codes for better UX
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed. Please install git and try again.${NC}"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository.${NC}"
    exit 1
fi

# Function to display the menu and get commit type
select_commit_type() {
    echo -e "${BLUE}Select a commit type:${NC}" >&2
    echo "1) feat     - A new feature" >&2
    echo "2) fix      - A bug fix" >&2
    echo "3) docs     - Documentation only changes" >&2
    echo "4) style    - Code style changes (formatting, etc.)" >&2
    echo "5) refactor - Code refactoring" >&2
    echo "6) perf     - Performance improvements" >&2
    echo "7) test     - Adding or updating tests" >&2
    echo "8) chore    - Maintenance tasks" >&2
    echo "" >&2

    while true; do
        read -p "Enter your choice (1-8): " choice
        case $choice in
            1) echo "feat"; return 0;;
            2) echo "fix"; return 0;;
            3) echo "docs"; return 0;;
            4) echo "style"; return 0;;
            5) echo "refactor"; return 0;;
            6) echo "perf"; return 0;;
            7) echo "test"; return 0;;
            8) echo "chore"; return 0;;
            *) echo -e "${RED}Invalid choice. Please select 1-8.${NC}" >&2;;
        esac
    done
}

# Function to get commit scope (optional)
get_scope() {
    read -p "Enter scope (optional, press enter to skip): " scope
    echo "$scope"
}

# Function to get commit message
get_message() {
    while true; do
        read -p "Enter commit message: " message
        if [[ -n "$message" ]]; then
            echo "$message"
            return 0
        else
            echo -e "${RED}Message cannot be empty. Please try again.${NC}"
        fi
    done
}

# Main commit command
commit() {
    echo -e "${GREEN}=== Create Git Commit ===${NC}"
    echo ""

    # Show git status
    echo -e "${BLUE}Current git status:${NC}"
    git status --short
    echo ""

    # Get commit type
    type=$(select_commit_type)
    echo ""

    # Get scope
    scope=$(get_scope)
    echo ""

    # Get message
    message=$(get_message)
    echo ""

    # Construct commit message
    if [[ -n "$scope" ]]; then
        commit_msg="${type}(${scope}): ${message}"
    else
        commit_msg="${type}: ${message}"
    fi

    # Display the commit message
    echo -e "${YELLOW}Commit message: ${commit_msg}${NC}"
    echo ""

    # Confirm before committing
    read -p "Proceed with commit? (y/n): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${YELLOW}Commit cancelled.${NC}"
        return 0
    fi

    # Stage all changes
    echo -e "${BLUE}Staging all changes...${NC}"
    git add -A

    # Execute git commit
    if git commit -m "$commit_msg"; then
        echo ""
        echo -e "${GREEN} Commit created successfully!${NC}"
    else
        echo ""
        echo -e "${RED} Failed to create commit.${NC}"
        return 1
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly
    commit
fi
