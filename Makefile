bindir=/sbin
sysconfdir=/etc
unitdir=$(sysconfdir)/systemd/system

INSTALL=install
SYSTEMCTL=systemctl

all:

install:
	$(INSTALL) -d -m 755 $(DESTDIR)$(bindir)
	$(INSTALL) akmod-sign-modules.sh -m 755 $(DESTDIR)$(bindir)
	$(INSTALL) -d -m 755 $(DESTDIR)$(unitdir)/akmods@.service.d
	$(INSTALL) override.conf -m 644 $(DESTDIR)$(unitdir)/akmods@.service.d/
	$(SYSTEMCTL) daemon-reload
