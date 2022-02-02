import Config

config :accountabot, Accountabot.Repo,
  database: "accountabot_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

  config :accountabot, ecto_repos: [Accountabot.Repo]
