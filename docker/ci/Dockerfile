FROM debian:bookworm-slim@sha256:abd67ffcfa541b485a3dff59865ab629aa048a6c613e639d36e7456b0b229241 AS builder

ARG MISE_VERSION=2026.8.3

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
      ca-certificates \
      curl \
      git \
    && rm -rf /var/lib/apt/lists/*

RUN curl --fail --silent --show-error --location \
      "https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64" \
      --output /usr/local/bin/mise \
    && chmod 0755 /usr/local/bin/mise

WORKDIR /workspace
COPY mise.toml .

ENV MISE_DATA_DIR=/opt/mise
RUN mise install --yes \
    && mkdir --parents /toolchain/usr/local/bin \
    && for tool in $(mise ls --current --no-header | awk '{print $1}'); do \
         cp "$(mise which "$tool")" "/toolchain/usr/local/bin/$tool"; \
       done

FROM debian:bookworm-slim@sha256:abd67ffcfa541b485a3dff59865ab629aa048a6c613e639d36e7456b0b229241

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
      bash \
      ca-certificates \
      git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /toolchain/usr/local/bin/ /usr/local/bin/
ENV PATH=/usr/local/bin:$PATH
