defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines, %{})
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      headers: headers,
      params: params
    }
  end

  def parse_headers([head | tail], headers_map) do
    [key, value] = String.split(head, ": ")
    headers_map = Map.put(headers_map, key, value)
    parse_headers(tail, headers_map)
  end

  def parse_headers([], headers), do: headers

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end
end
