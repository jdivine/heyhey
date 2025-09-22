#!/bin/bash

# Local CI/development helper script

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="ghcr.io/jdivine/heyhey"
GITHUB_USER="jdivine"

# Configure podman registries
configure_registries() {
    echo "Configuring podman registries..."
    
    # Create registries.conf directory if it doesn't exist
    REGISTRIES_DIR="$HOME/.config/containers"
    mkdir -p "$REGISTRIES_DIR"
    
    # Create minimal registries.conf file
    cat > "$REGISTRIES_DIR/registries.conf" << 'EOF'
# Minimal registries configuration for ghcr.io
[[registry]]
location = "ghcr.io"

[[registry]]  
location = "docker.io"
EOF
}

cmd_deps() {
    echo "Installing dependencies..."
    poetry sync --with dev
}

cmd_build() {
    echo "Building image..."
    podman build --tag heyhey:latest .
    podman tag heyhey:latest "$IMAGE_NAME:latest"
}

cmd_test() {
    echo "Running tests..."
    poetry run pytest -v
}

cmd_lint() {
    echo "Running code quality checks..."
    poetry run flake8 app/ tests/
}

cmd_ci() {
    echo "Running full CI pipeline..."
    cmd_deps
    cmd_lint
    cmd_test
    cmd_build
    cmd_smoke
    echo "CI pipeline completed successfully"
}

# Smoke test - quick container health check
cmd_smoke() {
    echo "Running smoke test..."
    
    # Start container w unique name and port to avoid conflicts
    podman run -d --name "heyhey-smoke" -p "8090:8080" heyhey:latest
    sleep 2
    
    # Test health endpoint with timeout and retries
    success=false
    for i in {1..10}; do
        if curl -f -s --connect-timeout 2 "http://localhost:8090/health" > /dev/null; then
            success=true
            break
        fi
        echo "Attempt $i failed, retrying..."
        sleep 1
    done
    
    podman stop "heyhey-smoke" > /dev/null 2>&1 || true
    podman rm "heyhey-smoke" > /dev/null 2>&1 || true
    
    if [ "$success" = true ]; then
        echo "Smoke test passed"
    else
        echo "Smoke test failed"
        exit 1
    fi
}

# Publish - push image to GitHub Container Registry
cmd_publish() {
    echo "Publishing image to GitHub Container Registry..."
    
    configure_registries
    
    if ! {
        gh auth token \
        | podman login ghcr.io --username "$GITHUB_USER" --password-stdin \
        && podman push "$IMAGE_NAME:latest"
    }; then
        echo "Publish failed"
        exit 1
    fi
    
    echo "Successfully published."
    echo "Pull with: podman pull $IMAGE_NAME:latest"
}

# Help command
cmd_help() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Available commands:"
    echo "  deps          - Install/update dependencies"
    echo "  lint          - Run code quality checks"
    echo "  test          - Run tests"
    echo "  build         - Build the container image"
    echo "  smoke         - Container smoke test"
    echo "  ci            - Run almost full CI pipeline (clean, deps, lint, test, build, smoke)"
    echo "  publish       - Push image to GitHub Container Registry"
    echo "  help          - Show this help message"
}

# Main command dispatcher
main() {
    cd "$SCRIPT_DIR"
    case "${1:-help}" in
        deps)
            cmd_deps
            ;;
        build)
            cmd_build
            ;;
        test)
            cmd_test
            ;;
        lint)
            cmd_lint
            ;;
        smoke)
            cmd_smoke
            ;;
        publish)
            cmd_publish
            ;;
        ci)
            cmd_ci
            ;;
        help|--help|-h)
            cmd_help
            ;;
        *)
            echo "Unknown command: $1"
            cmd_help
            exit 1
            ;;
    esac
}

main "$@"