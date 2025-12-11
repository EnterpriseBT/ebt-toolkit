#!/bin/bash
set -e

# Make scripts executable


chmod +x /usr/local/bin/ebt-cli/scripts/*
chmod +x /usr/local/bin/ebt-cli/lib/*

# Create symlink to make ebt-cli available in PATH
ln -s /usr/local/bin/ebt-cli/scripts/ebt.sh /usr/local/bin/ebt

# Enable git completion
/usr/local/bin/ebt-cli/lib/enable-git-completion.sh
