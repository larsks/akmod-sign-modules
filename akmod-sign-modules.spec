Name:           akmod-sign-modules
Version:        0.1
Release:        1.g6a14d4e%{?dist}
BuildArch:      noarch
Summary:        Automatically sign modules generated with akmods
License:        FIXME
URL:            https://github.com/larsks/akmod-sign-modules
# NOTE: use one of these
# * for local provided source use
# Source0:        akmod-sign-modules-0.1.tar.gz
# * for online GitHub sources use
# Source0:        %{url}/archive/%{version}/%{name}-%{version}.tar.gz

BuildRequires:  gzip
BuildRequires:  pandoc
BuildRequires:  systemd
Requires:       akmods
Requires:       bash
Requires:       systemd

%description
Automatically sign modules generated with akmods
so that they can be used on a system with UEFI Secure boot

WARNING: This package DOESN'T work out-of-the-box!
Signing keys aren't generated automatically, as they need to get
saved / authenticated to / by HW (Secure boot). Please follow instructions in
/usr/share/docs/akmod-sign-modules/README.md file, namely Prerequisites section.

%prep
%autosetup


%build
pandoc --standalone --to man akmod-sign-modules.sh.8.md --output akmod-sign-modules.sh.8 && gzip akmod-sign-modules.sh.8


%install
rm -rf $RPM_BUILD_ROOT
%{__install} -d -m 755 $RPM_BUILD_ROOT/%{_sbindir}
%{__install} -m 755 akmod-sign-modules.sh $RPM_BUILD_ROOT/%{_sbindir}/akmod-sign-modules.sh
%{__install} -d -m 755 $RPM_BUILD_ROOT/%{_unitdir}/akmods@.service.d
%{__install} -m 644 override.conf $RPM_BUILD_ROOT/%{_unitdir}/akmods@.service.d/
%{__install} -p -D -m 644 akmod-sign-modules.sh.8.gz $RPM_BUILD_ROOT/%{_mandir}/man8/akmod-sign-modules.sh.8.gz


%files
%license LICENSE
%doc README.md
%{_mandir}/man8/akmod-sign-modules.sh.8.gz
# expands to /usr/sbin/akmods-sign-modules.sh
%{_sbindir}/%{name}.sh
%{_unitdir}/akmods@.service.d/override.conf


%changelog
* Wed Nov 10 2021 Arnošt Dudek <arnost@arnostdudek.cz> - 0.1-1.g6a14d4e
- initial release
