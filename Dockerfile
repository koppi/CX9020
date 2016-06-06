FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN sudo dpkg --add-architecture i386; sudo apt-get update && sudo apt-get install -y multistrap qemu binfmt-support qemu-user-static mercurial libtool autoconf lib32z1 lib32ncurses5-dev lib32stdc++6 git make xz-utils bc wget ccache dpkg-dev

RUN git clone https://github.com/koppi/CX9020 
RUN cd CX9020 && ./tools/install_linaro_gcc.sh
RUN cd CX9020 && ./tools/prepare_uboot.sh v2015.07
RUN cd CX9020 && make uboot
RUN git config --global user.email "docker@localhost"
RUN git config --global user.name  "Docker"
RUN cd CX9020 && ./tools/prepare_kernel.sh 4.1 12 13
RUN cd CX9020 && make kernel
RUN cd CX9020 && ./tools/prepare_etherlab.sh
RUN cd CX9020 && make etherlab

