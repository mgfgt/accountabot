defmodule Accountabot.Repo do
  use Ecto.Repo,
    otp_app: :accountabot,
    adapter: Ecto.Adapters.Postgres
end
