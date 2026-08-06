#!/bin/bash

set -ex

archs="x86_64 aarch64"
input_version=$1
versions=${input_version:-"20.03-lts 20.03-lts-sp1 20.03-lts-sp2 20.03-lts-sp3 20.03-lts-sp4 20.09 21.03 21.09 22.03-lts 22.03-lts-sp1 22.03-lts-sp2 22.03-lts-sp3 22.03-lts-sp4 22.09 23.03 23.09 24.03-lts 24.09"}

for ARCH in $archs; do
    case "$ARCH" in
        "aarch64")
            DOCKER_ARCH=arm64
            ;;
        "x86_64")
            DOCKER_ARCH=amd64
            ;;
        *)
            echo "Unknown arch: $ARCH"
            exit 1
            ;;
    esac
    for VERSION in $versions; do
        mkdir -p $VERSION
        # Download
        cd $VERSION
        URL_VERSION=`echo $VERSION | tr 'a-z' 'A-Z'`
        if [ ! -f "openEuler-docker.$ARCH.tar.xz" ]; then
            wget https://repo.openeuler.org/openEuler-$URL_VERSION/docker_img/update/current/$ARCH/openEuler-docker.$ARCH.tar.xz
        fi
        # Re-download and validate sha256sum everytime
        rm -f openEuler-docker.$ARCH.tar.xz.sha256sum
        wget https://repo.openeuler.org/openEuler-$URL_VERSION/docker_img/update/current/$ARCH/openEuler-docker.$ARCH.tar.xz.sha256sum
        shasum -c openEuler-docker.$ARCH.tar.xz.sha256sum
        # Extract rootfs
        if [ ! -f "openEuler-docker-rootfs.$DOCKER_ARCH.tar.gz" ]; then
            tar -xf openEuler-docker.$ARCH.tar.xz --wildcards "*.tar" --exclude "layer.tar"
            rootfs_list=()
            while IFS= read -r rootfs; do
                rootfs_list+=("${rootfs#./}")
            done < <(find . -maxdepth 1 -type f -name "*.tar" ! -name "openEuler*")
            if [ "${#rootfs_list[@]}" -ne 1 ]; then
                echo "Expected one rootfs tar, found ${#rootfs_list[@]}"
                exit 1
            fi
            mv -f "${rootfs_list[0]}" "openEuler-docker-rootfs.$DOCKER_ARCH.tar"
            /usr/bin/tar -cf "openEuler-docker-rootfs.$DOCKER_ARCH.filtered.tar" --exclude 'usr/share/python-wheels/setuptools-*-py3-none-any.whl' @"openEuler-docker-rootfs.$DOCKER_ARCH.tar"
            mv -f "openEuler-docker-rootfs.$DOCKER_ARCH.filtered.tar" "openEuler-docker-rootfs.$DOCKER_ARCH.tar"
            gzip -f "openEuler-docker-rootfs.$DOCKER_ARCH.tar"
        fi
        cp -f ../Dockerfile ./
        cd ..
    done
done
