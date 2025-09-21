#!/bin/bash

# Local CI/development helper script

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dependencies command - install/update dependencies
cmd_deps() {
    echo "Installing dependencies..."
    # Install main and dev dependencies
    poetry sync --with dev
}

# Build command - build the project
cmd_build() {
    echo "Building project..."
    # Build the project using poetry
    poetry build
}

# Test command - run tests
cmd_test() {
    echo "Running tests..."
    # Run pytest with coverage if available
    poetry run pytest -v
}

# Lint command - code quality checks (if linter is available)
cmd_lint() {
    echo "Running code quality checks..."
    # Run linting if available
    poetry run flake8 app/ tests/ || true
}

# Full CI pipeline - clean, deps, lint, test, build
cmd_ci() {
    echo "Running full CI pipeline..."
    cmd_clean
    cmd_deps
    cmd_lint
    cmd_build
    cmd_test
    echo "CI pipeline completed successfully"
}

# Development server command
cmd_dev() {
    echo "Starting development server..."
    check_poetry
    
    # Run Flask development server
    poetry run python -m app.app
}

# Help command
cmd_help() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Available commands:"
    echo "  deps          - Install/update dependencies"
    echo "  build         - Build the project"
    echo "  test          - Run tests"
    echo "  lint          - Run code quality checks"
    echo "  ci            - Run full CI pipeline (clean, deps, lint, test, build)"
    echo "  help          - Show this help message"
}

# Main command dispatcher
main() {
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
        serve)
            cmd_serve
            ;;
        dev)
            cmd_dev
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