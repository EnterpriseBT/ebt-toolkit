FROM ubuntu:latest

# Install bash, git, and bash-completion for autocompletion
RUN apt-get update && \
    apt-get install -y bash git bash-completion && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set bash as the default shell
SHELL ["/bin/bash", "-c"]

# Set working directory
WORKDIR /workspace

# Copy CLI scripts
COPY scripts/ /usr/local/bin/ebt-cli-scripts/

# Make scripts executable
RUN chmod +x /usr/local/bin/ebt-cli-scripts/*.sh

# Source git prompt configuration
RUN echo 'if [ -f /usr/local/bin/ebt-cli-scripts/git-prompt.sh ]; then' >> /root/.bashrc && \
    echo '  source /usr/local/bin/ebt-cli-scripts/git-prompt.sh' >> /root/.bashrc && \
    echo 'fi' >> /root/.bashrc

# Create symlink to make ebt-cli available in PATH
RUN ln -s /usr/local/bin/ebt-cli-scripts/ebt.sh /usr/local/bin/ebt

# Enable bash completion system-wide
RUN echo 'if ! shopt -oq posix; then' >> /etc/bash.bashrc && \
    echo '  if [ -f /usr/share/bash-completion/bash_completion ]; then' >> /etc/bash.bashrc && \
    echo '    . /usr/share/bash-completion/bash_completion' >> /etc/bash.bashrc && \
    echo '  elif [ -f /etc/bash_completion ]; then' >> /etc/bash.bashrc && \
    echo '    . /etc/bash_completion' >> /etc/bash.bashrc && \
    echo '  fi' >> /etc/bash.bashrc && \
    echo 'fi' >> /etc/bash.bashrc

# Also enable for root user's .bashrc
RUN echo 'if [ -f /usr/share/bash-completion/bash_completion ]; then' >> /root/.bashrc && \
    echo '  . /usr/share/bash-completion/bash_completion' >> /root/.bashrc && \
    echo 'fi' >> /root/.bashrc

