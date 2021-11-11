% AKMOD-SIGN-MODULES(8) Version 0.1 | akmod-sign-modules User Manuals
% Lars Kellogg-Stedman, Arnošt Dudek
% November 23, 2021

# NAME

akmod-sign-modules.sh - Sign modules generated with akmods

# SYNOPSIS

akmod-sign-modules.sh *kernel-version*

# DESCRIPTION

Automatically sign modules generated with akmods
so that they can be used on a system with UEFI Secure boot.

\   **WARNING**: This package DOESN'T work out-of-the-box\!
      Signing keys aren't generated automatically, as they need to get
      saved / authenticated to / by HW (Secure boot). Please read instructions in
      */usr/share/docs/akmod-sign-modules/README.md* file,
      namely **Prerequisites section**.

and

\    **DON'T** call *akmod-sign-modules.sh* script directly, use *systemctl* as shown in **EXAMPLES**.

This script dynamically rebuilds kernel modules from source. Under
recent versions of Fedora, the akmods process is triggered when a new kernel
is installed by */usr/lib/kernel/install.d/95-akmodsposttrans.install*, which
ultimately runs - see full *README.md*.

# FILES

/usr/sbin/akmod-sign-modules.sh

/usr/share/docs/akmod-sing-modules/README.md

# EXAMPLES

   /bin/systemctl restart akmods@${KERNEL\_VERSION}.service
