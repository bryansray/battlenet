# Battlenet.Character.get("Greymane", "Virtualize")
# Battlenet.Guild.get("Greymane", "Solution")

defmodule Battlenet.Cache.URL do
  def get!(url) do
    url
    |> get_cache_file_for_url
    |> File.read
    |> handle_file_read(url)
  end

  defp handle_file_read({ :ok, content }, _), do: :erlang.binary_to_term(content)
  defp handle_file_read({ :error, _ }, url) do
    url
    |> Battlenet.API.Base.get!
    |> cache_result(url)
  end

  defp cache_result(content, url) do
    url
    |> get_cache_file_for_url
    |> File.write!(:erlang.term_to_binary(content))

    content
  end

  defp get_cache_file_for_url(url) do
    cache_location = Application.get_env(:battlenet, :cache_path, "./cache")
    filename = Base.url_encode64(url)

    Path.join(cache_location, filename)
  end
end