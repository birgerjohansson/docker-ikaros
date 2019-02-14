# Get the latest ubuntu package
FROM ubuntu:latest

# Update Ubuntu and get libraries
RUN apt-get update && apt-get install cmake g++ libjpeg-turbo8-dev libgsl0-dev libpng-dev libblas-dev curl libavcodec-dev libavformat-dev libswscale-dev libavdevice-dev git git-lfs -y && git lfs install && git clone http://github.com/ikaros-project/ikaros.git

WORKDIR /ikaros/Build

RUN cmake .. && make -j8
