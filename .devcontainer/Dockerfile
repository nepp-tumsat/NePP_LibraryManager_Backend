FROM mcr.microsoft.com/devcontainers/base:debian

ARG DEBIAN_FRONTEND=noninteractive
ARG RUBY_VERSION=3.4.7

# rbenv の場所と PATH を全レイヤーで有効化
ENV RBENV_ROOT=/home/vscode/.rbenv
ENV PATH=${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 必要パッケージ（Ruby ビルド + PostgreSQL + 画像処理など）
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential autoconf bison libssl-dev libyaml-dev libreadline-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm-dev libdb-dev \
  libpq-dev postgresql-client \
  libvips pkg-config git curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

USER vscode
SHELL ["/bin/bash", "-lc"]

# rbenv / ruby-build 導入 ＆ Ruby インストール
RUN git clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}" && \
    mkdir -p "${RBENV_ROOT}/plugins" && \
    git clone https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build" && \
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc && \
    "${RBENV_ROOT}/bin/rbenv" install -l | grep -q "^\s*${RUBY_VERSION}\s*$" || (cd "${RBENV_ROOT}/plugins/ruby-build" && git pull) && \
    "${RBENV_ROOT}/bin/rbenv" install -s "${RUBY_VERSION}" && \
    "${RBENV_ROOT}/bin/rbenv" global "${RUBY_VERSION}" && \
    "${RBENV_ROOT}/bin/rbenv" rehash && \
    "${RBENV_ROOT}/versions/${RUBY_VERSION}/bin/gem" update --system && \
    "${RBENV_ROOT}/versions/${RUBY_VERSION}/bin/gem" install bundler && \
    "${RBENV_ROOT}/bin/rbenv" rehash && \
    "${RBENV_ROOT}/bin/rbenv" exec gem install rails:7.2.1 && \
    "${RBENV_ROOT}/bin/rbenv" rehash

WORKDIR /workspaces/rails_app
RUN "${RBENV_ROOT}/versions/${RUBY_VERSION}/bin/bundle" config set --local path vendor/bundle
