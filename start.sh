#!/bin/bash

/usr/local/bin/rust_app &

cd /python_app/python_app && python3 app.py &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
