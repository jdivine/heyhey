# Copilot Instructions for heyhey

This is a simple Flask web application that demonstrates basic web development patterns. The project follows a minimal but clean architecture suitable for small to medium web applications.

## Project Structure

- **app/**: Main application package
  - `app.py`: Core Flask application with factory pattern (`create_app()`) and route definitions
  - `__init__.py`: Empty module file for package structure
- **tests/**: Test suite using pytest
  - `test_app.py`: Unit tests for Flask routes using test client fixture
  - `__init__.py`: Empty module file for package structure

## Architecture Patterns

### Flask Application Factory
The app uses the factory pattern in `app/app.py`:
- `create_app()` function creates and configures the Flask instance
- Routes are defined inside the factory function
- `main()` function serves as the CLI entry point

### Route Conventions
- `/`: Returns HTML content (`text/html` mimetype)
- `/health`: Returns JSON status for monitoring (`application/json` mimetype)
- All routes have docstrings describing their purpose

## Development Workflow

### Dependency Management
- **Poetry** is used for dependency management (see `pyproject.toml`)
- Main dependencies: Flask 3.1.2+
- Dev dependencies: pytest 8.4.2+
- Install dependencies: `poetry install`
- Add dependencies: `poetry add <package>`

### Testing
- **pytest** framework with Flask test client
- Test fixture pattern: `client()` fixture creates `app.test_client()`
- Test naming: `test_<functionality>()` with descriptive docstrings
- Assertions check both status codes and response content/mimetype
- Run tests: `pytest` or `poetry run pytest`

## Key Files to Understand

- `pyproject.toml`: Project configuration and dependencies (uses package-mode = false)
- `app/app.py`: Main application logic and routing
- `tests/test_app.py`: Test patterns and Flask testing approach
- `zz-local-ci.sh`: Local CI script for development tasks

## Running the Application

- Direct execution: `poetry run python -m app.app`
- Development server runs with `debug=True`
- Use CI script: `./zz-local-ci.sh test` or `./zz-local-ci.sh deps`

## Adding New Features

When adding routes:
1. Add route function inside `create_app()` with proper docstring
2. Use appropriate return types (`jsonify()` for JSON, strings for HTML)
3. Add corresponding test in `test_app.py` with fixture usage
4. Test both status codes and response content/mimetype
