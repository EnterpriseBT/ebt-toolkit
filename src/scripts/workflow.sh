# Create the target directory if it doesn't exist
mkdir -p /workspace/.github/workflows

# Copy the workflow template to the desired location
cp /usr/local/bin/ebt-toolkit/assets/workflow.template.yml /workspace/.github/workflows/docker_build_push.yml

# Prompt user for workflow name, registry, and image name
read -p "Enter workflow name: " workflow_name
read -p "Enter registry: " registry
read -p "Enter image name: " image_name

# Substitute values into the copied template
# macOS/BSD sed compatibility not guaranteed; this is for GNU sed (Linux containers)
sed -i "s|<name>|${workflow_name}|" /workspace/.github/workflows/docker_build_push.yml
sed -i "s|<registry>|${registry}|" /workspace/.github/workflows/docker_build_push.yml
sed -i "s|<image_name>|${image_name}|" /workspace/.github/workflows/docker_build_push.yml

# Print a success message
echo "Workflow generated successfully at /workspace/.github/workflows/docker_build_push.yml"