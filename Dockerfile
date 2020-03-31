FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y \
  linux-generic \
  grub-pc \
  cryptsetup \
  mdadm \
  openssh-server \
  dropbear \
  busybox \
  ifupdown \
  net-tools \
  iputils-ping \
  rsyslog \
  iptables \
  strace \
  lsof \
  tcpdump \
  ngrep \
  && \
  update-rc.d -f dropbear remove

RUN wget -O - https://get.docker.com/ | sh
RUN mkdir -p /root/.ssh/                                                   && \
  chmod 0755 /root/.ssh/                                                   && \
  rm -v /etc/ssh/ssh_host_* /etc/dropbear*/dropbear_*_host_key             && \
  echo CRYPTSETUP=y                >/etc/initramfs-tools/conf.d/cryptsetup && \
  echo -e "LANG=C\nLC_ALL=C"                          >>  /etc/environment && \
  echo '/dev/mapper/root / ext4 errors=remount-ro 0 1'>   /etc/fstab       && \
  sed  -i 's/_LINUX=.*$/_LINUX="net.ifnames=0 debug=vc"/' /etc/default/grub
