FROM ubuntu:24.04
RUN apt-get update -y
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y ubuntu-keyring debian-archive-keyring
#         kali-archive-keyring 
WORKDIR /build
ADD mkosi_kernel_repro.sh ./
# RUN ./mkosi_kernel_repro.sh
