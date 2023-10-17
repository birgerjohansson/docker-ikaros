FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get install cmake g++ libjpeg-turbo8-dev libgsl0-dev libpng-dev libblas-dev curl git git-lfs -y \ 
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& git lfs install \
&& git clone https://github.com/ikaros-project/ikaros.git

WORKDIR /ikaros/Build
RUN git pull && cmake -DCMAKE_BUILD_TYPE=Release .. && make && rm -rf /ikaros/Build/*
ENTRYPOINT ["/bin/bash"]