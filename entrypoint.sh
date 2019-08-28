#!/bin/bash

rm -f /root/.ravendarkcore/.lock /root/.ravendarkcore/ravendarkd.pid && \
ravendarkd && \
touch /root/.ravendarkcore/debug.log && \
cron && \
service rsyslog restart && \
tail -n 100 -f /root/.ravendarkcore/debug.log
