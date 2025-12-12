#!/bin/bash
set -e

# Make scripts executable
chmod +x /usr/local/bin/ebt-toolkit/scripts/*
chmod +x /usr/local/bin/ebt-toolkit/lib/*

# Create symlink to make ebt-toolkit available in PATH
ln -s /usr/local/bin/ebt-toolkit/scripts/ebt.sh /usr/local/bin/ebt

# Enable git completion
/usr/local/bin/ebt-toolkit/lib/enable-git-completion.sh