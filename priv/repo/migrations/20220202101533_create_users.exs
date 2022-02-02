defmodule Accountabot.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :discord_id, :bigint, primary_key: true
      add :username, :string
      add :discriminator, :string

      timestamps()
    end
  end
end
