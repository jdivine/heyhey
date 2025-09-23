# Heyhey - a sample app and pipeline project

- [Heyhey - a sample app and pipeline project](#heyhey---a-sample-app-and-pipeline-project)
  - [What Is This?](#what-is-this)
  - [How to Use](#how-to-use)
    - [Local CI pipeline and app](#local-ci-pipeline-and-app)
    - [Github Actions](#github-actions)
    - [Argo / k8s deployment](#argo--k8s-deployment)
  - [Homework steps](#homework-steps)
  - [Tools and resources used](#tools-and-resources-used)
  - [Problems Encountered and Solved](#problems-encountered-and-solved)
  - [Future enhancements for hypothetical production use](#future-enhancements-for-hypothetical-production-use)

## What Is This?
- Sample Python web app & associated DOckerfile
- CI pipeline using Github Actions (and a shell script to run all steps locally)
- Helm chart and supporting files for k8s deployment
- CD pipeline using Argo

## How to Use
### Local CI pipeline and app
- TODO
  
### Github Actions
- TODO

### Argo / k8s deployment
- Assumes a pre-existing install of minikube, kubectl, helm, etc
- Start a fresh minikube cluster with `minikube delete ; minikube delete`


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
- Set up a new minikube cluster
- Helm chart:
  - I told copilot to spin up a basic helm chart for deploying this image. It generated a pretty standard setup.
  - TODO
- ArgoCD:
  - Installed with the instructions here: https://argo-cd.readthedocs.io/en/stable/getting_started/
  - Local installation so I installed an ingress for it to access the API server
  - 
- TODO:
  - Shell script for CD actions

## Tools and resources used
- I did this work on WSL / Ubuntu 24.04 but it should work pretty much the same on Mac
- VS Code
- Github Copilot
  - I primarily use this for answering questions (basically in lieu of Stack Overflow) and to automate some refactorings.  I avoid using agent mode to create anything out of whole cloth - except for the initial Python webapp (which is basic, could have just copied something) and the helm chart (which are yucky to build.)
  - I generally use Claude Sonnet 4. Seems to produce results that make sense to me.
  - I'm happy to discuss how I use genAI in my work. In general I think it's a powerful tool if you already kind of know what needs to be done and take its suggestions with a grain of salt.
- Minikube
  - I chose to go with this since I already had it installed and have used it in the past.
- 

## Problems Encountered and Solved
- Poetry install was running into non-deterministic SSL errors locally on WSL. Seems like it happens when downloading large batches of packages - Python, Node, dpkg .. 
  - Hacky workaround added to the Dockerfile
  - I suspect something is going on with my home network - it's been slow and glitchy since a tree falling knocked down our overhead lines last month.
- Initially couldn't access the app running on port 8080 when running locally from the docker image.  I had to specify both container port and local port - I had forgotten that it didn't automatically use the exposed port number.
- Had permissions errors publishing from the workflow to the registry.  Struggled with this a while, tried a bunch of things including using some off the shelf actions, and nothing worked. Eventually realized that I needed to set permission on the registry to allow the repo to push, and I went back to the basic "call the shell script" approach I started with. (this was my first time using a Github registry for container images)


## Future enhancements for hypothetical production use
- an ingress with TLS enabled
- Auth layer somewhere
- Network security policies
- RBAC roles
- Pipeline checks for dependency vulnerabilities (dependabot or similar)
- Pipeline checks for code quality / code security
- Add a horizontal pod autoscaler
- Non-root Dockerfile
- More efficient Docker build
- More verification in helper script to make more foolproof
- More cowbell
- Pipeline caching (docker, python, etc)
- Version tags for git and docker
- Production-grade WSGI server like Gunicorn
- Probably lots of other things
