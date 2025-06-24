#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.15}

cd "$(realpath "$(dirname "${0}")")/srcpkgs"

if ! [[ -d linux$version-tkg-bore ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bore
    ln -sv linux"$version"-tkg-bore linux"$version"-tkg-bore-dbg
    ln -sv linux"$version"-tkg-bore linux"$version"-tkg-bore-headers
fi

if ! [[ -d linux$version-tkg-bore-alderlake ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bore-alderlake
    ln -sv linux"$version"-tkg-bore-alderlake linux"$version"-tkg-bore-alderlake-dbg
    ln -sv linux"$version"-tkg-bore-alderlake linux"$version"-tkg-bore-alderlake-headers
fi

if ! [[ -d linux$version-tkg-bore-zen ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bore-zen
    ln -sv linux"$version"-tkg-bore-zen linux"$version"-tkg-bore-zen-dbg
    ln -sv linux"$version"-tkg-bore-zen linux"$version"-tkg-bore-zen-headers
fi

cd ..

sed -i "s|# Template file for|# -*- sh -*-\n# Template file for|" srcpkgs/linux"$version"-tkg-bore/template srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|hostmakedepends|depends=\"hristoast-removed\"\nhostmakedepends|" srcpkgs/linux"$version"-tkg-bore/template srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|^linux$version|linux$version-tkg-bore-alderlake|;s|'linux$version'|'linux$version-tkg-bore-alderlake'|" srcpkgs/linux"$version"-tkg-bore-alderlake/template
sed -i "s|^linux$version|linux$version-tkg-bore-zen|;s|'linux$version'|'linux$version-tkg-bore-zen'|" srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|^linux$version|linux$version-tkg-bore|;s|'linux$version'|'linux$version-tkg-bore'|" srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|}_|}-tkg-bore-alderlake_|" srcpkgs/linux"$version"-tkg-bore-alderlake/template
sed -i "s|}_|}-tkg-bore-zen_|" srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|}_|}-tkg-bore_|" srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bore-alderlake|" srcpkgs/linux"$version"-tkg-bore-alderlake/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bore-zen|" srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bore|" srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|maintainer=\".* <.*@.*>|maintainer=\"Hristos <me@hristos.co>|" srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|series)\"|series with TKG patches)\"|" srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|archs=\"x86_64\* i686\* aarch64\*\"|archs=\"x86_64\*\"|" srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template
sed -i "s|\tsed -i -e \"s\|\^\\\(CONFIG|\t#sed -i -e \"s\|\^\\\(CONFIG|" srcpkgs/linux"$version"-tkg-bore-alderlake/template srcpkgs/linux"$version"-tkg-bore-zen/template srcpkgs/linux"$version"-tkg-bore/template
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bore-alderlake_1\"|" srcpkgs/linux"$version"-tkg-bore-alderlake/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bore-zen_1\"|" srcpkgs/linux"$version"-tkg-bore-zen/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bore_1\"|" srcpkgs/linux"$version"-tkg-bore/files/*

rm -f srcpkgs/linux"$version"-tkg-bore/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-bore-alderlake/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-bore-alderlake/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-bore-zen/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-bore-zen/files/i386-dotconfig
