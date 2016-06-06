FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN sudo dpkg --add-architecture i386; sudo apt-get update && sudo apt-get install -y multistrap qemu binfmt-support qemu-user-static mercurial libtool autoconf lib32z1 lib32ncurses5-dev lib32stdc++6 git make xz-utils bc wget

RUN ./tools/install_linaro_gcc.sh
RUN ./tools/prepare_uboot.sh v2015.07
RUN make uboot
RUN ./tools/prepare_kernel.sh 4.1 12 13
RUN make kernel
RUN ./tools/prepare_etherlab.sh
RUN make etherlab

