# Enterprise CLI

A dockerized CLI tool for enforcing git branching and commit formatting standards across your organization.

## Quick Start

### Pull the Docker Image

```bash
docker pull bbgrabbag/ebt-cli:latest
```

### Run the CLI

Run the CLI in your git repository:

```bash
docker run -it --rm -v $(pwd):/workspace bbgrabbag/ebt-cli:latest
```

Once inside the container, use the `ebt` command:

```bash
ebt <command>
```

## Available Commands

- `ebt create-branch` - Interactively create a new git branch with enforced naming conventions
- `ebt commit` - Interactively create a git commit with enforced formatting standards
- `ebt help` - Display help information

## Example Usage

```bash
# Create a new branch
ebt create-branch

# Make your changes, then commit
ebt commit
```

## Development

See [CLAUDE.md](CLAUDE.md) for project structure and development workflow.

