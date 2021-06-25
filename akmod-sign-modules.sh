#!/bin/sh

# inspired by https://gist.github.com/xenithorb/df08970b9e70bb3c6576e1fd91460afe

set -eu

LOG () {
	echo "${0##*/}: $*" >&2
}

DIE () {
	LOG "ERROR: $*"
	exit 1
}

if [ -z "$1" ]; then
	DIE "usage: $0 <kernel_version>"
fi

KERNEL_VER=$1

: ${MOK_KEY:=/etc/pki/tls/mok/mok.key}
: ${MOK_CRT:=/etc/pki/tls/mok/mok.der}
: ${MOK_HASH:=sha256}
: ${SIGN:=/usr/src/kernels/${KERNEL_VER}/scripts/sign-file}
: ${KMOD_RPM_DIR:=/var/cache/akmods}

LOG "Signing akmod-generated modules for kernel version $KERNEL_VER"

readarray -t kmods < <(
find "${KMOD_RPM_DIR}" -name "*${KERNEL_VER}*.rpm" |
	xargs rpm -qlp |
	grep '\.ko$'
)

LOG "Found ${#kmods[*]} modules"

for kmod in "${kmods[@]}"; do
	LOG "Signing $kmod"
	$SIGN $MOK_HASH $MOK_KEY $MOK_CRT "$kmod"
done
