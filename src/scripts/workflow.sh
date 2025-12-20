#!/bin/bash
set -e

# Prompt for destination folder
read -p "Enter destination folder path [/workspace/.github]: " dest_folder
dest_folder=${dest_folder:-/workspace/.github}

# Ensure destination .github folder exists
if [ ! -d "$dest_folder" ]; then
  echo "Creating folder: $dest_folder"
  mkdir -p "$dest_folder"
fi

# Ensure 'actions' subfolder exists
if [ ! -d "$dest_folder/actions" ]; then
  echo "Creating folder: $dest_folder/actions"
  mkdir -p "$dest_folder/actions"
fi

# Ensure 'workflows' subfolder exists
if [ ! -d "$dest_folder/workflows" ]; then
  echo "Creating folder: $dest_folder/workflows"
  mkdir -p "$dest_folder/workflows"
fi

# Copy *.action.template.yml files to actions, removing .template. in destination filenames
template_src="$pwd/assets/templates/github"
if compgen -G "$template_src/*.action.template.yml" > /dev/null; then
  echo "Copying *.action.template.yml files to $dest_folder/actions (removing .template.)"
  for srcfile in "$template_src"/*.action.template.yml; do
    filename=$(basename "$srcfile")
    destfile="${filename/.template./.}"
    cp "$srcfile" "$dest_folder/actions/$destfile"
  done
else
  echo "No *.action.template.yml files found in $template_src"
fi

# Copy *.workflow.template.yml files to workflows, removing .template. in destination filenames
if compgen -G "$template_src/*.workflow.template.yml" > /dev/null; then
  echo "Copying *.workflow.template.yml files to $dest_folder/workflows (removing .template.)"
  for srcfile in "$template_src"/*.workflow.template.yml; do
    filename=$(basename "$srcfile")
    destfile="${filename/.template./.}"
    cp "$srcfile" "$dest_folder/workflows/$destfile"
  done
else
  echo "No *.workflow.template.yml files found in $template_src"
fi

