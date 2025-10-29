# Docker-Ikaros Architecture

This document describes the technical architecture and design decisions for the Docker-Ikaros container.

## Overview

Docker-Ikaros provides a containerized environment for running the Ikaros robotics and AI framework. The container is based on Ubuntu 22.04 and includes all necessary dependencies for building and running Ikaros.

## Base Image

**Base:** `ubuntu:22.04`

Ubuntu 22.04 LTS (Jammy Jellyfish) was chosen for:
- Long-term support and stability
- Wide package availability
- Compatibility with Ikaros dependencies
- Familiar environment for most users

## Dockerfile Architecture

### Build Process

The Dockerfile follows a multi-step process:

1. **Base Image Selection**
   - Uses Ubuntu 22.04 as the foundation
   - Sets `DEBIAN_FRONTEND=noninteractive` to prevent interactive prompts during build

2. **Dependency Installation**
   The following packages are installed in a single layer:
   - **Build Tools:** `cmake`, `g++`
   - **Image Processing:** `libjpeg-turbo8-dev`, `libpng-dev`
   - **Scientific Computing:** `libgsl0-dev`, `libblas-dev`
   - **Version Control:** `git`, `git-lfs`
   - **Utilities:** `curl`

3. **Cleanup**
   - Removes apt cache to reduce image size
   - Follows Docker best practices for layer optimization

4. **Ikaros Installation**
   - Clones the official Ikaros repository from GitHub
   - Initializes Git LFS for large file support
   - Sets working directory to `/ikaros/Build`

5. **Ikaros Build**
   - Pulls latest changes
   - Uses CMake with Release configuration
   - Compiles the project
   - Cleans build artifacts to reduce image size

6. **Entry Point**
   - Sets `/bin/bash` as the default entry point for interactive use

### Directory Structure

```
/
├── ikaros/                 # Ikaros installation directory
│   ├── Bin/               # Compiled binaries
│   ├── Build/             # Build directory (cleaned after compilation)
│   ├── Examples/          # Example configurations
│   ├── Source/            # Source code
│   └── ...
```

## Image Layers

The Dockerfile is optimized to minimize the number of layers and image size:

1. **Layer 1:** Base Ubuntu image
2. **Layer 2:** Combined package installation and cleanup
3. **Layer 3:** Git clone and setup
4. **Layer 4:** Build and cleanup

## Dependencies

### System Dependencies

- **cmake:** Build system generator
- **g++:** C++ compiler for building Ikaros
- **libjpeg-turbo8-dev:** JPEG image processing library
- **libgsl0-dev:** GNU Scientific Library for mathematical computations
- **libpng-dev:** PNG image processing library
- **libblas-dev:** Basic Linear Algebra Subprograms library
- **curl:** Command-line tool for data transfer
- **git:** Version control for cloning repositories
- **git-lfs:** Git Large File Storage for handling large files

### Ikaros Dependencies

The Ikaros framework itself requires:
- C++ compiler with C++11 support
- CMake 3.x or higher
- Various scientific computing libraries

## Build Configuration

### CMake Configuration

- **Build Type:** Release
- **Optimizations:** Enabled for production use
- **Configuration:** Default Ikaros settings

### Compilation

The build process:
1. Generates build files with CMake
2. Compiles using make with default parallelization
3. Produces binaries in `/ikaros/Bin/`

## Port Mapping

The container is typically run with port 8000 exposed:
- **Port 8000:** Default port for Ikaros web interface (if applicable)

Additional ports can be mapped as needed based on specific Ikaros configurations.

## Security Considerations

### Current Security Features

- Uses official Ubuntu base image
- Installs only necessary dependencies
- Cleans package cache to reduce attack surface

### Potential Improvements

For production use, consider:
- Running as a non-root user
- Using multi-stage builds to further reduce image size
- Scanning for vulnerabilities with tools like Trivy
- Pinning specific versions of dependencies
- Using distroless or Alpine base for smaller footprint

## Performance Considerations

### Image Size Optimization

- Combined RUN commands to reduce layers
- Cleaned apt cache and build artifacts
- Removed build directory contents after compilation

### Runtime Performance

- Release build configuration for optimized execution
- Efficient library selection (e.g., libjpeg-turbo over standard libjpeg)

## Extensibility

The container can be extended by:

1. **Creating a derived image:**
   ```dockerfile
   FROM birgerjohansson/ikaros
   RUN apt-get update && apt-get install -y additional-package
   ```

2. **Mounting custom configurations:**
   ```bash
   docker run -v /path/to/configs:/configs birgerjohansson/ikaros
   ```

3. **Adding custom modules:**
   - Mount source directory
   - Rebuild inside container
   - Use persistent volumes for compiled modules

## Maintenance

### Updating Ikaros

To update to the latest Ikaros version:
1. Rebuild the Docker image (pulls latest from Git)
2. Or manually update inside a running container:
   ```bash
   cd /ikaros
   git pull
   cd Build
   cmake -DCMAKE_BUILD_TYPE=Release .. && make
   ```

### Updating Dependencies

Rebuild the image to get latest Ubuntu packages:
```bash
docker build --no-cache -t ikaros:latest .
```

## Future Improvements

Potential enhancements:
- Multi-stage build to separate build and runtime dependencies
- Non-root user for improved security
- Health checks for container monitoring
- Specific version pinning for reproducibility
- Alpine-based variant for smaller size
- Pre-built examples ready to run
- Integration with Docker Compose for complex setups

## References

- [Ikaros Project](https://github.com/ikaros-project/ikaros)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
