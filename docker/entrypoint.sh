#!/bin/bash
set -e

# Make scripts executable
chmod +x /usr/local/bin/ebt-cli-scripts/*.sh

# Source git prompt configuration
cat >> /root/.bashrc << 'EOF'
if [ -f /usr/local/bin/ebt-cli-scripts/git-prompt.sh ]; then
  source /usr/local/bin/ebt-cli-scripts/git-prompt.sh
fi
EOF

# Create symlink to make ebt-cli available in PATH
ln -s /usr/local/bin/ebt-cli-scripts/ebt.sh /usr/local/bin/ebt

# Enable bash completion system-wide
cat >> /etc/bash.bashrc << 'EOF'
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
EOF

# Also enable for root user's .bashrc
cat >> /root/.bashrc << 'EOF'
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
EOF
