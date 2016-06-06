FROM machinekit/mk-builder:jessie-armhf

ENV DEBIAN_FRONTEND noninteractive
RUN su - apt-get update && su - apt-get install -y mercurial libtool autoconfgit make xz-utils bc wget

RUN git clone https://github.com/koppi/CX9020
RUN git checkout mk

RUN cd CX9020 && ./tools/prepare_uboot.sh v2015.07
RUN cd CX9020 && make uboot
RUN cd CX9020 && ./tools/prepare_kernel.sh 4.1 12 13
RUN cd CX9020 && make kernel
RUN cd CX9020 && ./tools/prepare_etherlab.sh
RUN cd CX9020 && make etherlab

