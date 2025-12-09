#!/bin/bash

# ebt - Enterprise BT CLI Tool
# Main entry point for the CLI

# Get the directory where this script is located
# Resolve symlinks to get the actual script path
SCRIPT_PATH="${BASH_SOURCE[0]}"
if [ -L "$SCRIPT_PATH" ]; then
    SCRIPT_PATH="$(readlink -f "$SCRIPT_PATH")"
fi
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

# Color codes for better UX
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Display help message
show_help() {
    echo "ebt-cli - Enterprise BT CLI Tool"
    echo ""
    echo "Usage: ebt-cli <command>"
    echo ""
    echo "Available commands:"
    echo "  create-branch    Create a new git branch interactively"
    echo "  commit           Create a git commit interactively"
    echo "  help             Show help message"
    echo ""
}

# Main command dispatcher
case "$1" in
    create-branch)
        bash "$SCRIPT_DIR/create-branch.sh"
        ;;
    commit)
        bash "$SCRIPT_DIR/commit.sh"
        ;;
    help|--help|-h)
        show_help
        ;;
    "")
        echo -e "${RED}Error: No command provided${NC}"
        echo ""
        show_help
        exit 1
        ;;
    *)
        echo -e "${RED}Error: Unknown command '$1'${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
