defmodule MyBot do
  use Application
  alias Alchemy.Client

  defmodule Commands do
    use Alchemy.Cogs

    Cogs.def ping do
      Cogs.say "pong!"
    end
  end

  @token Application.fetch_env!(:mikuelixir, :token)

  def start(_type, _args) do
    run = Client.start(@token)
    use Commands
    run
  end
end
