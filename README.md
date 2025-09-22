# Heyhey - a sample app and pipeline project
- Sample Python web app
- container build
- CI pipeline using Github Actions (and a local shell script)
- Helm chart and supporting files for k8s deployment
- CD pipeline using Argo

## How to Run
### Local CI pipeline and app
- TODO
  
### Github Actions
- TODO

### Argo / k8s deployment
- TODO

## Homework steps
- Initial setup
  - I began by creating a Github repo.
  - Github then asked me if I wanted to use Copilot to initialize the repo, so I thought "what the heck." I had it initialize a basic Python webapp using Poetry, with a "/" and a "/health" endpoints and unit tests for each endpoint.
  - I made a few tweaks, and verified that the app fired up and that the unit tests ran and passed
- Shell script for local testing of CI actions
- Dockerfile
  - Grabbed an existing Dockerfile I had used for a Python/Poetry project before and modified it
- Github Actions workflow for CI
  - Just decided to call the shell script steps I'd already built.
- TODO:
  - Helm chart
  - k8s cluster
  - Shell script for CD actions
  - Argo

## Tools and resources used
- VS Code
- Github Copilot
  - I primarily used this for answering questions (basically in lieu of Stack Overflow) and for some small refactorings.  I avoided using agent mode to create anything out of whole cloth - except for the initial Python webapp
  - I generally use Claude Sonnet 4. Seems to produce results that make sense to me.
  - I'm happy to discuss how I use genAI in my work. In general I think it's a powerful tool if you already kind of know what needs to be done and take its suggestions with a grain of salt.

## Problems Encountered and Solved
- Poetry install running into non-deterministic SSL errors locally on WSL
  - Hacky workaround added to the Dockerfile
  - I suspect something isn't quite right with my WSL network config but didn't want to spend more time figuring out exactly what, since it only appears to affect this specific scenario
- Initially couldn't access the app running on port 8080 when running locally from the docker image.  I had to specify both container port and local port - I had forgotten that it didn't automatically use the exposed port number.
- Had permissions errors publishing from the workflow to the registry.  Struggled with this a while, tried a bunch of things including using some off the shelf actions, eventually realized that I needed to give permission to the repository to push to the container registry.


## Future enhancements for hypothetical production use
- HTTPS
- Network security policies for k8s
- Pipeline checks for dependency vulnerabilities (dependabot or similar)
- Pipeline checks for code quality / code security
- Add a horizontal pod autoscaler
- Non-root Dockerfile
- More efficient Docker build
- More cowbell
- Pipeline caching (docker, python, etc)
- Version tags for git and docker
- Production-grade WSGI server like Gunicorn
