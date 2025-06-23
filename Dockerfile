FROM caddy:2

RUN apt-get update && apt-get install -y \
    curl python3 python3-pip build-essential \
    && curl https://sh.rustup.rs -sSf | bash -s -- -y \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.cargo/bin:${PATH}"


WORKDIR /build-rust
COPY apps/rust_app ./rust_app
RUN cd rust_app && cargo build --release && cp target/release/rust_app /usr/local/bin/

WORKDIR /python_app
COPY apps/python_app ./python_app
RUN pip3 install -r python_app/requirements.txt


COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000

CMD ["/start.sh"]
