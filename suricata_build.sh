#!/bin/bash
sudo apt install libpcre3-dev libhyperscan-dev libyaml-dev libjansson-dev libpcap-dev libz-dev libnss3-dev libbpf-dev libnet-dev libmagic-dev liblz4-dev libcap-ng-dev libmaxminddb-dev

./configure --enable-luajit --enable-ebpf --enable-geoip
