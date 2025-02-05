# Elixir 1.18.2 + Erlang 26.1.2 + Debian 12 (Bookworm) Slim
FROM hexpm/elixir:1.18.2-erlang-26.1.2-debian-bookworm-20250203-slim

# 環境変数を設定
ENV LANG=C.UTF-8 \
    MIX_ENV=dev \
    TERM=xterm

# 必要なパッケージをインストール
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        bash \
        inotify-tools && \
    rm -rf /var/lib/apt/lists/*

# Node.js 18.x をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# npm を `10.x` に固定
RUN npm install -g npm@10.8.2

# Hex & Rebar をインストール
RUN mix local.hex --force && \
    mix local.rebar --force

# Phoenix CLI をインストール
RUN mix archive.install hex phx_new 1.7.19 --force

# 作業ディレクトリを設定
WORKDIR /app

# ポートを開放
EXPOSE 4000

CMD ["/bin/bash"]
