# Docker-Ikaros

A Docker container for running [Ikaros](https://github.com/ikaros-project/ikaros), a framework for robotics and AI systems. This container provides a complete, isolated environment with all necessary dependencies pre-installed and Ikaros pre-built.

## Overview

Docker-Ikaros simplifies the deployment and use of the Ikaros framework by packaging it in a Docker container. This eliminates the need to manually install dependencies and build Ikaros on your local system.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your system
- Basic familiarity with Docker commands
- At least 2GB of free disk space

## Quick Start

```bash
# Pull the latest image from Docker Hub
docker pull birgerjohansson/ikaros

# Run the container interactively
docker run -i -t -p 8000:8000 birgerjohansson/ikaros
```

## Installation

### Option 1: Pull from Docker Hub (Recommended)

The easiest way to get started:

```bash
docker pull birgerjohansson/ikaros
```

### Option 2: Build from GitHub

Build directly from the repository:

```bash
docker build -t ikaros:latest https://github.com/birgerjohansson/docker-ikaros.git
```

### Option 3: Build Locally

Clone and build locally:

```bash
git clone https://github.com/birgerjohansson/docker-ikaros.git
cd docker-ikaros
docker build -t ikaros:latest .
```

## Usage

### Interactive Mode

Start an interactive bash session inside the container:

```bash
docker run -i -t -p 8000:8000 birgerjohansson/ikaros /bin/bash
```

Inside the container, Ikaros is available at `/ikaros/`:
- **Binaries:** `/ikaros/Bin/`
- **Examples:** `/ikaros/Examples/`
- **Source:** `/ikaros/Source/`

### Running Ikaros Commands

Execute Ikaros directly:

```bash
docker run birgerjohansson/ikaros /ikaros/Bin/ikaros --help
```

### Working with Local Files

Mount a local directory to work with your own projects:

```bash
docker run -i -t -v $(pwd)/my-projects:/workspace -p 8000:8000 birgerjohansson/ikaros
```

Inside the container:
```bash
cd /workspace
/ikaros/Bin/ikaros my-configuration.ikc
```

## What's Included

The container includes:

- **Ubuntu 22.04 LTS** - Base operating system
- **Ikaros** - Latest version from the official repository
- **Development Tools** - CMake, G++, and other build essentials
- **Libraries** - Image processing (JPEG, PNG), scientific computing (GSL, BLAS)
- **Git LFS** - For handling large files

## Port Mapping

By default, the container exposes port 8000 for the Ikaros web interface (if applicable):

```bash
docker run -i -t -p 8000:8000 birgerjohansson/ikaros
```

You can map to a different host port:

```bash
docker run -i -t -p 8080:8000 birgerjohansson/ikaros
```

## Documentation

For more detailed information, see:

- [**USAGE.md**](USAGE.md) - Comprehensive usage guide with examples
- [**ARCHITECTURE.md**](ARCHITECTURE.md) - Technical details about the Docker setup
- [**CONTRIBUTING.md**](CONTRIBUTING.md) - Guidelines for contributors

## Examples

### Run a Specific Example

```bash
docker run birgerjohansson/ikaros /bin/bash -c "cd /ikaros/Examples && /ikaros/Bin/ikaros example.ikc"
```

### Development Workflow

```bash
# Start container with your project directory mounted
docker run -i -t \
  -v $(pwd)/my-ikaros-project:/workspace \
  -p 8000:8000 \
  birgerjohansson/ikaros /bin/bash

# Inside container
cd /workspace
/ikaros/Bin/ikaros my-config.ikc
```

## Troubleshooting

### Port Already in Use

If port 8000 is already in use, map to a different port:

```bash
docker run -i -t -p 8001:8000 birgerjohansson/ikaros
```

### Permission Issues with Mounted Volumes

Ensure your local directory has appropriate permissions, or run the container with matching user ID:

```bash
docker run -i -t -u $(id -u):$(id -g) -v $(pwd):/workspace birgerjohansson/ikaros
```

### Container Won't Start

Check the logs:

```bash
docker logs <container-id>
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Resources

- [Ikaros Project Repository](https://github.com/ikaros-project/ikaros)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub Page](https://hub.docker.com/r/birgerjohansson/ikaros)

## License

This Docker configuration is provided as-is. Please refer to the [Ikaros project](https://github.com/ikaros-project/ikaros) for its licensing terms.

## Acknowledgments

- The [Ikaros Project](https://github.com/ikaros-project/ikaros) team for developing the framework
- The Docker community for best practices and tools

## Support

For issues related to:
- **This Docker container:** Open an issue in this repository
- **Ikaros itself:** Visit the [Ikaros repository](https://github.com/ikaros-project/ikaros)

