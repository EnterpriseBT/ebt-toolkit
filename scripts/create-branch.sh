#!/bin/bash

# Simple Bash CLI Library for Branch Management

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

# Function to display the menu and get user selection
select_prefix() {
    echo -e "${BLUE}Select a branch prefix:${NC}" >&2
    echo "1) feature" >&2
    echo "2) patch" >&2
    echo "3) ci" >&2
    echo "4) doc" >&2
    echo "5) performance" >&2
    echo "6) refactor" >&2
    echo "" >&2

    while true; do
        echo -n "Enter your choice (1-6): " >&2
        read choice
        case $choice in
            1) echo "feature"; return 0;;
            2) echo "patch"; return 0;;
            3) echo "ci"; return 0;;
            4) echo "doc"; return 0;;
            5) echo "performance"; return 0;;
            6) echo "refactor"; return 0;;
            *) echo -e "${RED}Invalid choice. Please select 1-6.${NC}" >&2;;
        esac
    done
}

# Function to get Jira ticket
get_ticket() {
    while true; do
        read -p "Enter ticket # (e.g., PROJ-123): " ticket
        if [[ -n "$ticket" ]]; then
            echo "$ticket"
            return 0
        else
            echo -e "${RED}Ticket cannot be empty. Please try again.${NC}"
        fi
    done
}

# Function to get branch title
get_title() {
    while true; do
        read -p "Enter branch title: " title
        if [[ -n "$title" ]]; then
            # Replace spaces with hyphens and convert to lowercase
            title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            echo "$title"
            return 0
        else
            echo -e "${RED}Title cannot be empty. Please try again.${NC}"
        fi
    done
}

# Main create-branch command
create-branch() {
    echo -e "${GREEN}=== Create New Branch ===${NC}"
    echo ""

    # Get prefix
    prefix=$(select_prefix)
    echo ""

    # Get ticket
    ticket=$(get_ticket)
    echo ""

    # Get title
    title=$(get_title)
    echo ""

    # Construct branch name
    branch_name="${prefix}/${ticket}/${title}"

    # Display the branch name
    echo -e "${YELLOW}Creating branch: ${branch_name}${NC}"
    echo ""

    # Execute git checkout
    if git checkout -b "$branch_name"; then
        echo -e "${GREEN} Branch created successfully!${NC}"
    else
        echo -e "${RED} Failed to create branch.${NC}"
        return 1
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly
    create-branch
fi
