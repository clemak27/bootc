dnf clean all

rm -rf /tmp/* || true
rm -rf /usr/etc
rm -rf /boot && mkdir /boot

# preserve cache mounts
find /var/* -maxdepth 0 -type d \! -name cache \! -name log -exec rm -rf {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 -exec rm -rf {} \;

# make sure /var/tmp is properly created
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
