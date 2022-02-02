defmodule Accountabot.UserContext do
  @spec get_user(integer) :: %Accountabot.User{} | nil
  def get_user(id) do
    Accountabot.Repo.get(Accountabot.User, id)
  end

  @spec new_user(integer, String.t(), String.t()) :: %Accountabot.User{}
  def new_user(id, username, discriminator) do
    user_model = %Accountabot.User{
      discord_id: id,
      username: username,
      discriminator: discriminator
    }
    changeset = Accountabot.User.changeset(user_model, %{})
    Accountabot.Repo.insert!(changeset)
  end
end
