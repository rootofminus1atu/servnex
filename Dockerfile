FROM caddy:2

RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    build-base \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"


WORKDIR /build-rust
COPY apps/rust_app ./rust_app
RUN cd rust_app && cargo build --release && cp target/release/rust_app /usr/local/bin/

WORKDIR /python_app
COPY apps/python_app ./python_app
RUN pip3 install --break-system-packages -r python_app/requirements.txt


COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000

CMD ["/start.sh"]
