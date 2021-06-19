# Docker images with Z88DK

## Building Docker images

### Building Docker image based on Ubuntu
```shell-script
docker build -t gstolarz/z88dk -t gstolarz/z88dk:2.1 \
  --build-arg Z88DK_VERSION=2.1 .
```

### Building Docker image based on Alpine
```shell-script
docker build -t gstolarz/z88dk:alpine -t gstolarz/z88dk:2.1-alpine \
  --build-arg Z88DK_VERSION=2.1 -f Dockerfile-alpine .
```
