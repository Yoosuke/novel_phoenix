defmodule CodeLingo.Repo do
  use Ecto.Repo,
    otp_app: :code_lingo,
    adapter: Ecto.Adapters.Postgres
end
