#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.14}

cd "$(realpath "$(dirname "${0}")")/srcpkgs"

if ! [[ -d linux$version-tkg-bmq ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bmq
    ln -sv linux"$version"-tkg-bmq linux"$version"-tkg-bmq-dbg
    ln -sv linux"$version"-tkg-bmq linux"$version"-tkg-bmq-headers
fi

if ! [[ -d linux$version-tkg-bmq-alderlake ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bmq-alderlake
    ln -sv linux"$version"-tkg-bmq-alderlake linux"$version"-tkg-bmq-alderlake-dbg
    ln -sv linux"$version"-tkg-bmq-alderlake linux"$version"-tkg-bmq-alderlake-headers
fi

if ! [[ -d linux$version-tkg-bmq-zen ]]; then
    cp -ar linux"$version" linux"$version"-tkg-bmq-zen
    ln -sv linux"$version"-tkg-bmq-zen linux"$version"-tkg-bmq-zen-dbg
    ln -sv linux"$version"-tkg-bmq-zen linux"$version"-tkg-bmq-zen-headers
fi

cd ..

sed -i "s|^linux$version|linux$version-tkg-bmq-alderlake|;s|'linux$version'|'linux$version-tkg-bmq-alderlake'|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template
sed -i "s|^linux$version|linux$version-tkg-bmq-zen|;s|'linux$version'|'linux$version-tkg-bmq-zen'|" srcpkgs/linux"$version"-tkg-bmq-zen/template
sed -i "s|^linux$version|linux$version-tkg-bmq|;s|'linux$version'|'linux$version-tkg-bmq'|" srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-bmq-alderlake_\${revision}\"|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-bmq-zen_\${revision}\"|" srcpkgs/linux"$version"-tkg-bmq-zen/template
sed -i "s|_kernver=\"\${version}_\${revision}\"|_kernver=\"\${version}-tkg-bmq_\${revision}\"|" srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bmq-alderlake|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bmq-zen|" srcpkgs/linux"$version"-tkg-bmq-zen/template
sed -i "s|pkgname=linux$version|pkgname=linux$version-tkg-bmq|" srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|maintainer=\".* <.*@.*>|maintainer=\"Hristos <me@hristos.co>|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template srcpkgs/linux"$version"-tkg-bmq-zen/template srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|series)\"|series with TKG patches)\"|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template srcpkgs/linux"$version"-tkg-bmq-zen/template srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|archs=\"x86_64\* i686\* aarch64\*\"|archs=\"x86_64\*\"|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template srcpkgs/linux"$version"-tkg-bmq-zen/template
sed -i "s|\tsed -i -e \"s\|\^\\\(CONFIG|\t#sed -i -e \"s\|\^\\\(CONFIG|" srcpkgs/linux"$version"-tkg-bmq-alderlake/template srcpkgs/linux"$version"-tkg-bmq-zen/template srcpkgs/linux"$version"-tkg-bmq/template
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bmq-alderlake_1\"|" srcpkgs/linux"$version"-tkg-bmq-alderlake/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bmq-zen_1\"|" srcpkgs/linux"$version"-tkg-bmq-zen/files/x86_64-dotconfig
sed -i "s|CONFIG_LOCALVERSION=\"_1\"|CONFIG_LOCALVERSION=\"-tkg-bmq_1\"|" srcpkgs/linux"$version"-tkg-bmq/files/*

rm -f srcpkgs/linux"$version"-tkg-bmq/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-bmq-alderlake/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-bmq-alderlake/files/i386-dotconfig \
   srcpkgs/linux"$version"-tkg-bmq-zen/files/arm64-dotconfig \
   srcpkgs/linux"$version"-tkg-bmq-zen/files/i386-dotconfig
