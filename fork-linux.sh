#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.6}

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
