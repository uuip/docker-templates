RUN sed -i -E 's#https?://(repo|mirrors)\.openeuler\.org/#https://mirrors.ustc.edu.cn/openeuler/#g' /etc/yum.repos.d/openEuler.repo \
    && yum makecache
WORKDIR /tmp
ADD ./LibreOffice_7.4.7.2_Linux_aarch64_rpm.tar.gz .
RUN cd LibreOffice_7.4.7.2_Linux_aarch64_rpm/RPMS/  \
    && dnf install -y gnutls cairo libXinerama dbus-libs nss cups-libs libSM avahi-libs fontconfig libglvnd libglvnd-egl libglvnd-glx libxslt *.rpm  \
    && rm -rf /tmp/LibreOffice* && rm -rf /opt/libreoffice7.4/share/extensions && mkdir -p /opt/libreoffice7.4/share/extensions
