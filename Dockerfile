FROM caddy:2

RUN apk add --no-cache libcap && setcap -r /usr/bin/caddy

RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    build-base \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"


WORKDIR /build-rust
COPY apps/rust_app .
RUN cargo build --release && cp target/release/rust_app /usr/local/bin/

WORKDIR /python_app
COPY apps/python_app .
RUN ls -l /python_app
RUN pip3 install --break-system-packages -r requirements.txt


COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN echo "--- DEBUG ---" && ls -l / && cat /start.sh || true
RUN echo "--- DEBUG start.sh ---" && ls -l /start.sh && file /start.sh && cat /start.sh || true


EXPOSE 10000

CMD ["sh", "/start.sh"]

