# Docker-ikaros
Ikaros over Docker

## Pull from docker hub
```bash
docker pull birgerjohansson/ikaros
```

## Build
```bash
docker build -t ikaros:latest github.com/birgerjohansson/docker-ikaros
```

## Run
```bash
docker run -i -t -p 8000:8000 birgerjohansson/ikaros
```

## What's included

This Docker image is based on Ubuntu 24.04 LTS and includes:
- CMake
- g++
- Development libraries: libjpeg-turbo, libgsl, libpng, libblas
- Git and Git LFS
- The latest IKAROS source code from https://github.com/ikaros-project/ikaros

## Building IKAROS

The IKAROS source code is cloned to `/ikaros` but not automatically built due to current compilation issues in the upstream repository. To build manually once these issues are resolved:

```bash
docker run -it birgerjohansson/ikaros
cd /ikaros/Build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

## Updates

- **2025-10-29**: Updated to Ubuntu 24.04 LTS
- **2025-10-29**: Fixed SSL certificate issues during Docker build
- **2025-10-29**: Disabled automatic build due to upstream compilation issues in the IKAROS repository
