defmodule Accountabot do
  use Application

  @impl true
  def start( _type, _args) do
    Accountabot.Supervisor.start_link(name: Accountabot.Supervisor)
  end
end

defmodule Accountabot.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {Accountabot.Consumer, name: Accountabot.Consumer}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule Accountabot.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Consumer
  alias Nostrum.Api

  def start_link() do
    Consumer.start_link(__MODULE__)
  end

  # def handle_event({:READY, conn, _ws_state}) do
  # end

  def handle_event({:GUILD_AVAILABLE, guild, _ws_state}) do
    register_commands(guild.id)
  end

  def handle_event(_event) do
    :noop
  end

  def register_commands(guild_id) do
    Api.create_guild_application_command(guild_id, Commands.register())
  end
end
