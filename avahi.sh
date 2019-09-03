#!/bin/bash
apt-get -y install avahi-daemon

systemctl enable avahi-daemon
systemctl start avahi-daemon
