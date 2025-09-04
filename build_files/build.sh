#!/bin/bash

set -ouex pipefail

copy_systemfiles_for() {
	WHAT=$1
	shift
	DISPLAY_NAME=$WHAT
	if [ "${CUSTOM_NAME}" != "" ] ; then
		DISPLAY_NAME=$CUSTOM_NAME
	fi
	printf "::group:: ===%s-file-copying===\n" "${DISPLAY_NAME}"
    printf "--->${CONTEXT_PATH}/$WHAT/.<--"
	cp -avf "${CONTEXT_PATH}/$WHAT/." /
	printf "::endgroup::\n"
}

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
    gparted

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

## Don't automatically start Steam
rm /etc/xdg/autostart/steam.desktop


CUSTOM_NAME=
copy_systemfiles_for yapakipe_system_files

sed -i '$ a\"Yapakipe post-update fixes" = "/usr/libexec/topgrade/yapakipe-post-update"' /etc/ublue-os/topgrade.toml

