# Docker-Ikaros Usage Guide

This guide provides detailed instructions for using the Docker-Ikaros container.

## Table of Contents

- [Quick Start](#quick-start)
- [Getting the Image](#getting-the-image)
- [Running the Container](#running-the-container)
- [Working with Ikaros](#working-with-ikaros)
- [Advanced Usage](#advanced-usage)
- [Examples](#examples)

## Quick Start

The fastest way to get started:

```bash
# Pull the image
docker pull birgerjohansson/ikaros

# Run interactively
docker run -i -t -p 8000:8000 birgerjohansson/ikaros
```

## Getting the Image

### Option 1: Pull from Docker Hub (Recommended)

```bash
docker pull birgerjohansson/ikaros
```

### Option 2: Build from Source

Build from the GitHub repository:

```bash
docker build -t ikaros:latest https://github.com/birgerjohansson/docker-ikaros.git
```

Or build from a local clone:

```bash
git clone https://github.com/birgerjohansson/docker-ikaros.git
cd docker-ikaros
docker build -t ikaros:latest .
```

## Running the Container

### Interactive Mode

Start an interactive bash session inside the container:

```bash
docker run -i -t birgerjohansson/ikaros /bin/bash
```

With port mapping (if running web interface):

```bash
docker run -i -t -p 8000:8000 birgerjohansson/ikaros /bin/bash
```

### Running Ikaros Commands

Execute Ikaros directly:

```bash
docker run birgerjohansson/ikaros /ikaros/Bin/ikaros -h
```

### Mounting Local Files

To work with your own Ikaros projects, mount a local directory:

```bash
docker run -i -t -v /path/to/your/projects:/workspace \
  birgerjohansson/ikaros /bin/bash
```

Inside the container:
```bash
cd /workspace
/ikaros/Bin/ikaros your-project.ikc
```

## Working with Ikaros

### Ikaros Installation Location

Inside the container, Ikaros is installed at:
- **Source:** `/ikaros/`
- **Binaries:** `/ikaros/Bin/`
- **Examples:** `/ikaros/Examples/`

### Running Ikaros Examples

```bash
# Start the container
docker run -i -t birgerjohansson/ikaros /bin/bash

# Inside the container, navigate to examples
cd /ikaros/Examples

# Run an example (adjust path as needed)
/ikaros/Bin/ikaros example.ikc
```

### Web Interface

If Ikaros provides a web interface, expose the appropriate port:

```bash
docker run -i -t -p 8000:8000 birgerjohansson/ikaros /bin/bash
```

Then access it at `http://localhost:8000` in your browser.

## Advanced Usage

### Custom Port Mapping

Map different ports as needed:

```bash
docker run -i -t -p 8080:8000 -p 9000:9000 birgerjohansson/ikaros /bin/bash
```

### Running in Detached Mode

Run the container in the background:

```bash
docker run -d --name ikaros-instance -p 8000:8000 birgerjohansson/ikaros /bin/bash
```

Attach to the running container:

```bash
docker attach ikaros-instance
```

### Environment Variables

Set custom environment variables:

```bash
docker run -i -t -e "MY_VAR=value" birgerjohansson/ikaros /bin/bash
```

### Persistent Data

Create a Docker volume for persistent storage:

```bash
docker volume create ikaros-data
docker run -i -t -v ikaros-data:/data birgerjohansson/ikaros /bin/bash
```

### Resource Limits

Limit CPU and memory usage:

```bash
docker run -i -t --cpus="2" --memory="4g" birgerjohansson/ikaros /bin/bash
```

## Examples

### Example 1: Quick Test

```bash
# Pull and run
docker pull birgerjohansson/ikaros
docker run birgerjohansson/ikaros /ikaros/Bin/ikaros --version
```

### Example 2: Development Workflow

```bash
# Start container with your project mounted
docker run -i -t -v $(pwd)/my-project:/workspace \
  -p 8000:8000 \
  birgerjohansson/ikaros /bin/bash

# Inside container
cd /workspace
/ikaros/Bin/ikaros my-config.ikc
```

### Example 3: Automated Execution

```bash
# Run a specific Ikaros configuration and exit
docker run --rm \
  -v $(pwd)/configs:/configs \
  birgerjohansson/ikaros \
  /ikaros/Bin/ikaros /configs/my-setup.ikc
```

## Troubleshooting

### Container Won't Start

Check Docker logs:
```bash
docker logs <container-id>
```

### Port Already in Use

Change the host port:
```bash
docker run -i -t -p 8001:8000 birgerjohansson/ikaros /bin/bash
```

### Permission Issues

Run with appropriate user permissions or use Docker volumes.

## Additional Resources

- [Ikaros Project Repository](https://github.com/ikaros-project/ikaros)
- [Docker Documentation](https://docs.docker.com/)
- [Docker-Ikaros Repository](https://github.com/birgerjohansson/docker-ikaros)
