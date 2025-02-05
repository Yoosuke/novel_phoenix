#!/bin/bash

# ディレクトリを指定して mix コマンドを実行
d_mix() {
  local project=$1
  shift
  WORKDIR="/app/${project}" docker-compose run --rm elixir mix "$@"
}

# Phoenix サーバーを起動
d_phx() {
  local project=$1
  WORKDIR="/app/${project}" docker-compose run --rm --service-ports elixir iex -S mix phx.server
}

# 利用方法
if [[ $# -lt 2 ]]; then
  echo "Usage:"
  echo "  ./sc/mix.sh <project> <mix_command>"
  echo "  Example: ./sc/mix.sh code_lingo deps.get"
  echo "  Example: ./sc/mix.sh novel_engine run priv/repo/seeds.exs"
  exit 1
fi

# `phx.server` の場合は `d_phx` を使う
if [[ "$2" == "phx.server" ]]; then
  d_phx "$@"
else
  d_mix "$@"
fi
