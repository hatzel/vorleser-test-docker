FROM debian:unstable

WORKDIR /root

# common packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates curl file \
    build-essential \
    pkg-config \
    ffmpeg \
    libavcodec-dev \
    libavformat-dev \
    libavfilter-dev \
    libpq-dev \
    libavdevice-dev \
    libavresample-dev \
    autoconf automake autotools-dev libtool xutils-dev && \
    rm -rf /var/lib/apt/lists/*

# install toolchain using rustup
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly -y

ENV PATH=/root/.cargo/bin:$PATH

# install diesel cli
RUN cargo install diesel_cli --no-default-features --features "postgres" --verbose

RUN apt update
RUN apt-get install build-essential  clang -y
ENV PATH /root/.cargo/bin:$PATH