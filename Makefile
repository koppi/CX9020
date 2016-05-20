ETHERLAB=ethercat-hg
KERNEL=kernel
UBOOT=u-boot

etherlab:
	cd ${ETHERLAB} && ./configure --disable-generic --disable-8139too --disable-eoe --enable-tool --enable-ccat
	cd ${ETHERLAB} && make ARCH=arm clean
	cd ${ETHERLAB} && make ARCH=arm  
	cd ${ETHERLAB} && make ARCH=arm modules

uboot:
	cd ${UBOOT} && make ARCH=arm distclean
	cd ${UBOOT} && make ARCH=arm mx53cx9020_defconfig
	cd ${UBOOT} && make ARCH=arm

kernel-oldconfig:
	cd ${KERNEL} && make ARCH=arm oldconfig
	cd ${KERNEL} && make ARCH=arm menuconfig
	cp -a ${KERNEL}/.config kernel-patches/config-CX9020

kernel:
	cd ${KERNEL} && make ARCH=arm
	cd ${KERNEL} && make ARCH=arm modules
	cd ${KERNEL} && make ARCH=arm imx53-cx9020.dtb
	cp -a ${KERNEL}/.config kernel-patches/config-CX9020

kernel-debs:
	cd ${KERNEL} && CONCURRENCY_LEVEL=`getconf _NPROCESSORS_ONLN` DEB_HOST_ARCH=armhf fakeroot make-kpkg --append-to-version .cx9020 --revision `date +%Y%m%d%H%M%S` kernel_image kernel_headers

.PHONY: busybox dropbear glibc kernel install uboot prepare_disk install_rootfs install_small install_smallrootfs post_install install_debian
