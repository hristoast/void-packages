#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.12}

cd "$(realpath "$(dirname "${0}")")/srcpkgs"

if ! [[ -d linux$version-tkg-pds ]]; then
    cp -ar linux"$version" linux"$version"-tkg-pds
    ln -sv linux"$version"-tkg-pds linux"$version"-tkg-pds-dbg
    ln -sv linux"$version"-tkg-pds linux"$version"-tkg-pds-headers
fi

if ! [[ -d linux$version-tkg-pds-alderlake ]]; then
    cp -ar linux"$version" linux"$version"-tkg-pds-alderlake
    ln -sv linux"$version"-tkg-pds-alderlake linux"$version"-tkg-pds-alderlake-dbg
    ln -sv linux"$version"-tkg-pds-alderlake linux"$version"-tkg-pds-alderlake-headers
fi

if ! [[ -d linux$version-tkg-pds-zen ]]; then
    cp -ar linux"$version" linux"$version"-tkg-pds-zen
    ln -sv linux"$version"-tkg-pds-zen linux"$version"-tkg-pds-zen-dbg
    ln -sv linux"$version"-tkg-pds-zen linux"$version"-tkg-pds-zen-headers
fi

cd ..

sed -i "s|^linux$version|linux$version-tkg-pds-alderlake|;s|'linux$version'|'linux$version-tkg-pds-alderlake'|" srcpkgs/linux"$version"-tkg-pds-alderlake/template
sed -i "s|^linux$version|linux$version-tkg-pds-zen|;s|'linux$version'|'linux$version-tkg-pds-zen'|" srcpkgs/linux"$version"-tkg-pds-zen/template
sed -i "s|^linux$version|linux$version-tkg-pds|;s|'linux$version'|'linux$version-tkg-pds'|" srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-pds-alderlake_\${revision}\"|" srcpkgs/linux"$version"-tkg-pds-alderlake/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-pds-zen_\${revision}\"|" srcpkgs/linux"$version"-tkg-pds-zen/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-pds_\${revision}\"|" srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-pds-alderlake|" srcpkgs/linux"$version"-tkg-pds-alderlake/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-pds-zen|" srcpkgs/linux"$version"-tkg-pds-zen/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-pds|" srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|maintainer=\".* <.*@.*>|maintainer=\"Hristos <me@hristos.co>|" srcpkgs/linux"$version"-tkg-pds-alderlake/template srcpkgs/linux"$version"-tkg-pds-zen/template srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|series)\"|series with TKG patches)\"|" srcpkgs/linux"$version"-tkg-pds-alderlake/template srcpkgs/linux"$version"-tkg-pds-zen/template srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|archs=\"x86_64\* i686\* aarch64\*\"|archs=\"x86_64\*\"|" srcpkgs/linux"$version"-tkg-pds-alderlake/template srcpkgs/linux"$version"-tkg-pds-zen/template
sed -i "s|\tsed -i -e \"s\|\^\\\(CONFIG|\t#sed -i -e \"s\|\^\\\(CONFIG|" srcpkgs/linux"$version"-tkg-pds-alderlake/template srcpkgs/linux"$version"-tkg-pds-zen/template srcpkgs/linux"$version"-tkg-pds/template
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-pds-alderlake_1\"|" srcpkgs/linux"$version"-tkg-pds-alderlake/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-pds-zen_1\"|" srcpkgs/linux"$version"-tkg-pds-zen/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-pds_1\"|" srcpkgs/linux"$version"-tkg-pds/files/*

rm -f srcpkgs/linux"$version"-tkg-pds-alderlake/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-pds-alderlake/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-pds-zen/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-pds-zen/files/i386-dotconfig
