# heyhey
Hey Hey

## Homework steps

- Initial setup
  - I began by creating a Github repo.
  - Github then asked me if I wanted to use Copilot to initialize the repo, so I thought "what the heck." I had it initialize a basic Python webapp using Poetry, with a "/" and a "/health" endpoints and unit tests for each endpoint.
  - I made a few tweaks to the structure, and verified that the app fired up and that the unit tests ran and passed
- Shell script for local testing of CI actions
- Dockerfile
  - Grabbed an existing Dockerfile I had used for a Python/Poetry project before and modified it
- TODO:
  - Github Actions workflow for CI
  - Helm chart
  - k8s cluster
  - Shell script for CD actions
  - Argo

## Future enhancements

- HTTPS
- Network security policies for k8s
- Pipeline checks for dependency vulnerabilities (dependabot or similar)
- Pipeline checks for code quality / code security
- Add a horizontal pod autoscaler
- Non-root Dockerfile
- More efficient Docker build
- More cowbell
- Production-grade WSGI server like Gunicorn
