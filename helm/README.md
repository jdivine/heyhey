# HeyHey Helm Chart

A Helm chart for deploying the HeyHey Flask web application to Kubernetes.

## Installation

### Prerequisites
- Kubernetes cluster
- Helm 3.x
- kubectl configured to access your cluster
- Authentication to GitHub Container Registry (ghcr.io)

### Authentication Setup

The application image is hosted on GitHub Container Registry, so you need to create an image pull secret:

#### Option 1: Using the CI script (Recommended)
```bash
# If you have GitHub CLI authenticated:
./zz-local-ci.sh deploy

# Or with a GitHub token:
GITHUB_TOKEN=your_token_here ./zz-local-ci.sh deploy
```

#### Option 2: Manual secret creation
```bash
# Create namespace
kubectl create namespace heyhey

# Create image pull secret
kubectl create secret docker-registry ghcr-secret \
  --namespace=heyhey \
  --docker-server=ghcr.io \
  --docker-username=jdivine \
  --docker-password=your_github_token

# Install the chart
helm install heyhey ./helm/heyhey --namespace=heyhey
```

### Deploy the Application

1. **Deploy with default values:**
   ```bash
   helm install heyhey ./helm/heyhey
   ```

2. **Deploy with custom values:**
   ```bash
   helm install heyhey ./helm/heyhey --set replicaCount=3 --set image.tag=v1.0.0
   ```

3. **Deploy with custom values file:**
   ```bash
   helm install heyhey ./helm/heyhey -f my-values.yaml
   ```

## Configuration

The following table lists the configurable parameters and their default values:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `2` |
| `image.repository` | Container image repository | `ghcr.io/jdivine/heyhey` |
| `image.tag` | Container image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `service.targetPort` | Container port | `8080` |
| `ingress.enabled` | Enable ingress | `false` |
| `resources.limits.cpu` | CPU limit | `200m` |
| `resources.limits.memory` | Memory limit | `256Mi` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `128Mi` |
| `healthCheck.enabled` | Enable health checks | `true` |
| `healthCheck.path` | Health check endpoint | `/health` |

## Examples

### Enable Ingress
```yaml
# values-ingress.yaml
ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: heyhey.example.com
      paths:
        - path: /
          pathType: Prefix
```

Deploy with:
```bash
helm install heyhey ./helm/heyhey -f values-ingress.yaml
```

### Production Configuration
```yaml
# values-production.yaml
replicaCount: 3
image:
  tag: "v1.0.0"
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 200m
    memory: 256Mi
autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
```

## Uninstalling

```bash
helm uninstall heyhey
```

## Testing

After installation, test the deployment:

```bash
# Port forward to test locally
kubectl port-forward service/heyhey 8080:80

# Test the health endpoint
curl http://localhost:8080/health

# Test the main endpoint
curl http://localhost:8080/
```