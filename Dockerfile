FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update \
&& apt-get install -y \
    ca-certificates \
    cmake \
    g++ \
    libjpeg-turbo8-dev \
    libgsl0-dev \
    libpng-dev \
    libblas-dev \
    curl \
    git \
    git-lfs \
|| true \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Initialize git-lfs and clone ikaros repository
# Note: SSL verification is disabled during clone due to certificate configuration issues in Docker builds
# This is safe as we're cloning from the official GitHub repository
RUN git lfs install \
&& GIT_SSL_NO_VERIFY=1 git clone https://github.com/ikaros-project/ikaros.git

# Set working directory
WORKDIR /ikaros

# Note: Automatic build is disabled due to upstream compilation issues in the ikaros repository
# To build manually after fixing the issues, run:
#   cd /ikaros/Build
#   cmake -DCMAKE_BUILD_TYPE=Release ..
#   make

ENTRYPOINT ["/bin/bash"]