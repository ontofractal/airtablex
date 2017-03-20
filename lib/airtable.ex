defmodule Airtable do
  use HTTPoison.Base

  def fetch_records(table_name) do
     records = build_url(table_name)
       |> Airtable.get
       |> handle_response
       |> Poison.decode!
       |> Map.get("records")
       |> Enum.map(&Airtable.Record.new/1)
     {:ok, records}
  end

  def fetch_record(table_name, id: id) do
    record = build_url(table_name) <>  "/" <> id
      |> Airtable.get
      |> handle_response
      |> Poison.decode!
    {:ok, record}
  end


  def build_url(table) do
    base = Application.get_env(:airtable, :base)
    "https://api.airtable.com/v0/#{base}/#{table}"
  end


  defp process_request_headers(headers) do
    api_key = Application.get_env(:airtable, :api_key)
    Enum.into(headers, [{"Authorization", "Bearer " <> api_key}])
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        raise "Airtable error: status code #{status_code}"
      {:error, %HTTPoison.Error{reason: reason}} ->
        raise "HTTP error: " <> reason
      end
  end


end
