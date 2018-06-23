defmodule Servy.Parser do
  def parse(request) do
    # TODO: Parse the request string into a map:
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, resp_body: "", status: nil}
  end
end
