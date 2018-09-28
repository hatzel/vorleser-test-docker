FROM debian:unstable

WORKDIR /root

# required packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates curl file \
    build-essential \
    pkg-config \
    cmake \
    zlib1g \
    zlib1g-dev \
    ffmpeg \
    libsqlite3-0 \
    libsqlite3-dev \
    libavcodec-dev \
    libavformat-dev \
    libavfilter-dev \
    libssl-dev \
    libavdevice-dev \
    libavresample-dev \
    autoconf automake autotools-dev libtool xutils-dev && \
    rm -rf /var/lib/apt/lists/*

# install toolchain using rustup
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly-2018-09-27 -y

ENV PATH=/root/.cargo/bin:$PATH

RUN apt update
RUN apt-get install build-essential  clang -y
RUN RUSTFLAGS="--cfg procmacro2_semver_exempt" cargo install cargo-tarpaulin
ENV PATH /root/.cargo/bin:$PATH
