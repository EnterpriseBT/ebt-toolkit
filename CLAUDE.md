# Project: EBT CLI (CLAUDE.md)

## Overview
This project is a dockerized bash script CLI for enforcing specific formatting standards for git branching and code committing.

It is intended to be used aross multiple repositories across the entire organization to ensure all projects and services follow the same version control conventions.

## Structure
- `scripts/`: shell scripts to be run by the user consuming this library

## Workflow
CI/CD actions ensures that production, staging and feature builds of this docker image are available in the docker hub registry.
