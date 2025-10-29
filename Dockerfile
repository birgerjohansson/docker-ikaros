# Dockerfile for Ikaros - A robotics and AI framework
# Based on Ubuntu 22.04 LTS for stability and compatibility

FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies and clone Ikaros repository
# - cmake, g++: Build tools for compiling Ikaros
# - libjpeg-turbo8-dev, libpng-dev: Image processing libraries
# - libgsl0-dev: GNU Scientific Library for mathematical computations
# - libblas-dev: Basic Linear Algebra Subprograms library
# - curl: Utility for data transfer
# - git, git-lfs: Version control and large file support
RUN apt-get update \
&& apt-get install cmake g++ libjpeg-turbo8-dev libgsl0-dev libpng-dev libblas-dev curl git git-lfs -y \ 
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& git lfs install \
&& git clone https://github.com/ikaros-project/ikaros.git

# Set working directory to the build folder
WORKDIR /ikaros/Build

# Build Ikaros with CMake in Release mode for optimized performance
# Clean build artifacts to reduce image size
RUN git pull && cmake -DCMAKE_BUILD_TYPE=Release .. && make && rm -rf /ikaros/Build/*

# Set default entry point to bash for interactive use
ENTRYPOINT ["/bin/bash"]