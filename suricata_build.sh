#!/bin/bash
sudo apt install libpcre3-dev libhyperscan-dev libyaml-dev libjansson-dev libpcap-dev libz-dev libnss3-dev libbpf-dev libnet-dev libmagic-dev liblz4-dev libcap-ng-dev libmaxminddb-dev

./configure --enable-luajit --enable-ebpf --enable-geoip

sudo make -j32
sudo make install-full
sudo cp etc/suricata.logrotate /etc/logrotate.d/suricata.logrotate
sudo cp etc/suricata.service /etc/systemd/system/suricata.service
sudo systemctl daemon-reload
sudo systemctl enable suricata
sudo suricata-update update-sources
sudo suricata-update enable-source ptresearch/attackdetection
sudo suricata-update enable-source sslbl/ssl-fp-blacklist
sudo suricata-update enable-source sslbl/ja3-fingerprints
sudo suricata-update enable-source etnetera/aggressive
sudo suricata-update enable-source tgreen/hunting
sudo suricata-update update --ignore \*events.rules
