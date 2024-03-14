#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.9}

cd "$(realpath "$(dirname "${0}")")/srcpkgs"

if ! [[ -d linux$version-tkg ]]; then
    cp -ar linux"$version" linux"$version"-tkg
    ln -sv linux"$version"-tkg linux"$version"-tkg-dbg
    ln -sv linux"$version"-tkg linux"$version"-tkg-headers
fi

if ! [[ -d linux$version-tkg-alderlake ]]; then
    cp -ar linux"$version" linux"$version"-tkg-alderlake
    ln -sv linux"$version"-tkg-alderlake linux"$version"-tkg-alderlake-dbg
    ln -sv linux"$version"-tkg-alderlake linux"$version"-tkg-alderlake-headers
fi

if ! [[ -d linux$version-tkg-zen ]]; then
    cp -ar linux"$version" linux"$version"-tkg-zen
    ln -sv linux"$version"-tkg-zen linux"$version"-tkg-zen-dbg
    ln -sv linux"$version"-tkg-zen linux"$version"-tkg-zen-headers
fi

cd ..

sed -i "s|^linux$version|linux$version-tkg-alderlake|;s|'linux$version'|'linux$version-tkg-alderlake'|" srcpkgs/linux"$version"-tkg-alderlake/template
sed -i "s|^linux$version|linux$version-tkg-zen|;s|'linux$version'|'linux$version-tkg-zen'|" srcpkgs/linux"$version"-tkg-zen/template
sed -i "s|^linux$version|linux$version-tkg|;s|'linux$version'|'linux$version-tkg'|" srcpkgs/linux"$version"-tkg/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-alderlake_\${revision}\"|" srcpkgs/linux"$version"-tkg-alderlake/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-zen_\${revision}\"|" srcpkgs/linux"$version"-tkg-zen/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg_\${revision}\"|" srcpkgs/linux"$version"-tkg/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-alderlake|" srcpkgs/linux"$version"-tkg-alderlake/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-zen|" srcpkgs/linux"$version"-tkg-zen/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg|" srcpkgs/linux"$version"-tkg/template
sed -i "s|maintainer=\".* <.*@.*>|maintainer=\"Hristos <me@hristos.co>|" srcpkgs/linux"$version"-tkg-alderlake/template srcpkgs/linux"$version"-tkg-zen/template srcpkgs/linux"$version"-tkg/template
sed -i "s|series)\"|series with TKG patches)\"|" srcpkgs/linux"$version"-tkg-alderlake/template srcpkgs/linux"$version"-tkg-zen/template srcpkgs/linux"$version"-tkg/template
sed -i "s|archs=\"x86_64\* i686\* aarch64\*\"|archs=\"x86_64\*\"|" srcpkgs/linux"$version"-tkg-alderlake/template srcpkgs/linux"$version"-tkg-zen/template
sed -i "s|\tsed -i -e \"s\|\^\\\(CONFIG|\t#sed -i -e \"s\|\^\\\(CONFIG|" srcpkgs/linux"$version"-tkg-alderlake/template srcpkgs/linux"$version"-tkg-zen/template srcpkgs/linux"$version"-tkg/template
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-alderlake_1\"|" srcpkgs/linux"$version"-tkg-alderlake/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-zen_1\"|" srcpkgs/linux"$version"-tkg-zen/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg_1\"|" srcpkgs/linux"$version"-tkg/files/*

rm -f srcpkgs/linux"$version"-tkg-alderlake/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-alderlake/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-zen/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-zen/files/i386-dotconfig
