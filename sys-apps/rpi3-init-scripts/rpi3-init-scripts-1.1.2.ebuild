# Copyright (c) 2017 sakaki <sakaki@deciban.com>
# License: GPL v3+
# NO WARRANTY

EAPI=5

KEYWORDS="~arm64"

DESCRIPTION="Misc init scripts for the gentoo-on-rpi3-64bit image"
HOMEPAGE="https://github.com/sakaki-/gentoo-on-rpi3-64bit"
SRC_URI=""
LICENSE="GPL-3+"
SLOT="0"
IUSE=""
RESTRICT="mirror"
AR_SVCNAME="autoexpand-root"

# required by Portage, as we have no SRC_URI...
S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	>=x11-apps/xdm-1.1.11-r3
	>=sys-apps/openrc-0.21
	>=app-shells/bash-4.0"

src_install() {
	newinitd "${FILESDIR}/init.d_autoexpand_root-3" "${AR_SVCNAME}"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		rc-update add "${AR_SVCNAME}" boot
		elog "The first-boot root partition resizing service has been activated."
		elog "To have it run (which also force-sets the root and demouser"
		elog "passwords, and starts an Xfce session for demouser), create (touch)"
		elog "the sentinel file /boot/autoexpand_root_partition."
		elog "To do the same (but skipping the autoexpand step) create"
		elog "(touch) the file /boot/autoexpand_root_none instead."
		elog "To disable entirely, run:"
		elog "  rc-update del ${AR_SVCNAME} boot"
	fi
}

