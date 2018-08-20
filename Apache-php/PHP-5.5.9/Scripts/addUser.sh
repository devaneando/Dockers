#!/bin/bash

id -u thanos >/dev/null 2>&1
if [ $? -ne 0 ]; then
    adduser --home /home/thanos \
        --shell /bin/bash \
        --uid 1000 \
        --disabled-password \
        --gecos "" \
        thanos
fi
