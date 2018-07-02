defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    IO.puts "Running fetch"
    issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{body: body, status_code: 200}}) do
    IO.puts "Running handle_response"
    {:ok, :jsx.decode(body)}
  end

  def handle_response({_, %{status_code: __, body: body}}) do
    {:error, :jsx.decode(body)}
  end
end
