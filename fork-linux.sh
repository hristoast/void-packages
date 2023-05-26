#!/usr/bin/env bash
set -euo pipefail

version=${KERNVER-6.3}

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
