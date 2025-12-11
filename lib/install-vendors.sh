#!/bin/bash
set -e

echo "Installing vendor CLIs..."


# Detect architecture for AWS CLI
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    AWS_CLI_ARCH="x86_64"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    AWS_CLI_ARCH="aarch64"
else
    echo "Warning: Unsupported architecture for AWS CLI: $ARCH"
    exit 1
fi

# Install AWS CLI
echo "Installing AWS CLI for $AWS_CLI_ARCH..."
curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Verify AWS CLI installation
if command -v aws &> /dev/null; then
    echo "AWS CLI installed successfully: $(aws --version)"
else
    echo "Error: AWS CLI installation failed"
    exit 1
fi

# Install GitHub CLI
echo "Installing GitHub CLI..."

mkdir -p /usr/share/keyrings

# Import GitHub CLI GPG key and set up repo
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg

chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
https://cli.github.com/packages stable main" \
  | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

apt-get update
apt-get install -y gh
rm -rf /var/lib/apt/lists/*

# Verify GitHub CLI installation
if command -v gh &> /dev/null; then
  echo "GitHub CLI installed successfully: $(gh --version | head -n 1)"
else
  echo "Error: GitHub CLI installation failed"
  exit 1
fi

echo "All vendor CLIs installed successfully!"