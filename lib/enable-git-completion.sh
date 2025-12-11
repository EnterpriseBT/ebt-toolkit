#!/bin/bash

# Source git prompt configuration
cat >> /root/.bashrc << 'EOF'
if [ -f /usr/local/bin/ebt-cli/lib/git-prompt.sh ]; then
  source /usr/local/bin/ebt-cli/lib/git-prompt.sh
fi
EOF

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
