defmodule Accountabot.User do
  use Ecto.Schema

  @primary_key false
  schema "users" do
    field :discord_id, :integer, primary_key: true
    field :username, :string
    field :discriminator, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:discord_id, :username, :discriminator])
    |> Ecto.Changeset.validate_required([:discord_id, :username, :discriminator])
  end
end
