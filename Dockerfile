FROM ubuntu:18.04

RUN apt-get update \
&& apt-get install cmake g++ libjpeg-turbo8-dev libgsl0-dev libpng-dev libblas-dev curl libavcodec-dev libavformat-dev libswscale-dev libavdevice-dev git git-lfs -y \ 
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& git lfs install \
&& git clone http://github.com/ikaros-project/ikaros.git

WORKDIR /ikaros/Build
RUN cmake -DCMAKE_BUILD_TYPE=Release .. && make && rm -rf /ikaros/Build/*
