#!/bin/bash

rm -f /root/data/.lock /root/data/ravendarkd.pid && \
ravendarkd && \
touch /root/data/debug.log && \
cron && \
service rsyslog restart && \
tail -n 100 -f /root/data/debug.log
