# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop

DESCRIPTION="Visual Studio Code is a source-code editor developed by Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${P}-amd64.tar.gz"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=app-crypt/libsecret-0.18.5:0[crypt]
>=dev-libs/libdbusmenu-16.04.0
>=dev-libs/nss-3.47.1-r1:0
>=media-libs/alsa-lib-1.1.8:0
>=media-libs/libpng-1.2.46:0
>=net-print/cups-2.1.4:0
>=x11-libs/cairo-1.14.12:0
>=x11-libs/gtk+-3.10.0:3
>=x11-libs/libnotify-0.7.7:0
>=x11-libs/libXScrnSaver-1.2.2-r1:0
>=x11-libs/libXtst-1.2.3:0"

QA_PRESTRIPPED="opt/${PN}/code"
QA_PREBUILT="opt/${PN}/code"

pkg_setup() {
	if use amd64; then
		S="${WORKDIR}/VSCode-linux-x64"
	else
		die
	fi
}

src_install() {
	dodir "/opt"
	cp -pPR "${S}" "${D}/opt/${PN}" || die "Failed to copy files"
	dosym "${EPREFIX}/opt/${PN}/bin/code" "/usr/bin/code"
	make_desktop_entry "code" "Visual Studio Code" "${PN}" "Development;IDE"
	newicon "${S}/resources/app/resources/linux/code.png" "${PN}.png"
}
