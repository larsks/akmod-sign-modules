bindir=/sbin
sysconfdir=/etc
unitdir=$(sysconfdir)/systemd/system

INSTALL=install

all:

install:
	$(INSTALL) -d -m 755 $(bindir)
	$(INSTALL) akmod-sign-modules.sh -m 755 $(bindir)
	$(INSTALL) -d -m 755 $(sysconfdir)
	$(INSTALL) override.conf -m 644 $(unitdir)/akmods@.service.d/
	systemctl daemon-reload
