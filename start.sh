#!/bin/sh

echo "rust app running on port 5000"
/usr/local/bin/rust_app &

echo "python app running on port 8000"
cd /python_app && python3 app.py &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
