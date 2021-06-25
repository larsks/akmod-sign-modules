# Sign modules generated with akmods

Automatically sign modules generated with `akmods` so that they can be
used on a system with UEFI [secure boot].

[secure boot]: https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Secure_Boot

## Overview

The [akmods][] package dynamically rebuilds kernel modules from
source. Under recent versions of Fedora, the `akmods` process is
triggered when a new kernel is installed by
`/usr/lib/kernel/install.d/95-akmodsposttrans.install`, which
ultimately runs:

[akmods]: https://rpmfusion.org/Packaging/KernelModules/Akmods

```
/bin/systemctl restart akmods@${KERNEL_VERSION}.service
```

Because `akmods` is running as a [systemd][] [service][], we can
modify its behavior using a systemd [drop-in configuration
file][drop-in].

[systemd]: https://www.freedesktop.org/wiki/Software/systemd/
[service]: https://www.freedesktop.org/software/systemd/man/systemd.service.html
[drop-in]: https://wiki.archlinux.org/title/Systemd#Drop-in_files

By adding a second `ExecStart` directive, we can run our own script
after the `akmods` process has finished.

## Prerequisites

This repository has been written and tested on Fedora 34. It might
work on earlier releases, and maybe even on other distributions, but
I've never tried it.

You need to have previously [configured a certificate and key for
signing modules][enroll].

[enroll]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/signing-kernel-modules-for-secure-boot_managing-monitoring-and-updating-the-kernel

## Installation

1. Place your signing key in `/etc/pki/tls/mok/mok.key` and your
   certificate (in DER format) in `/etc/pki/tls/mok/mok.der`.

1. Install the `akmods` package

1. Run `make install` as `root`. This will:

    - Install `akmod-sign-modules.sh` into `/sbin`.
    - Install `override.conf` into
      `/etc/systemd/system/akmods@.service.d`
    - Run `systemctl daemon-reload` to make `systemd` aware of the
      override configuration.
