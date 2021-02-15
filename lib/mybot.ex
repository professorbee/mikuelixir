defmodule MyBot do
  use Application
  alias Alchemy.Client

  defmodule Commands do
    use Alchemy.Cogs

    Cogs.def miku do
      case HTTPoison.get("https://plushmiku.xyz/api/random") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Cogs.say("https://plushmiku.xyz/" <> Jason.decode!(body)["username"])
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          Cogs.say "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
    end
  end

  @token Application.fetch_env!(:mikuelixir, :token)

  def start(_type, _args) do
    run = Client.start(@token)
    Alchemy.Cogs.set_prefix("%")
    use Commands
    run
  end
end
