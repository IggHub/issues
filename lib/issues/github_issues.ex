defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]

  def fetch(user, project) do
    IO.puts "Running fetch"
    issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{body: body, status_code: 200}}) do
    IO.puts "running handle_response"
    {:ok, body}
  end

  def handle_response({_, %{status_code: __, body: body}}) do
    {:error, body}
  end
end
