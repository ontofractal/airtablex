defmodule Airtable do
  use Tesla
  alias Airtable.Record
  @api_key Application.get_env(:airtable, :api_key)
  @base Application.get_env(:airtable, :base)

  plug(Tesla.Middleware.BaseUrl, "https://api.airtable.com/v0/#{@base}/")
  plug(Tesla.Middleware.Headers, [{"Authorization", "Bearer #{@api_key}"}])
  plug(Tesla.Middleware.JSON)

  def new() do
    Tesla.build_client([])
  end

  def fetch_records(table, opts \\ %{}) do
    offset = opts[:offset]

    case get!(new(), table, query: [offset: offset]) do
      %{status: 200, body: %{"records" => records, "offset" => offset}} ->
        {:ok, next_offset_records} = fetch_records(table, %{offset: offset})
        {:ok, Enum.map(records, &Record.new/1) ++ next_offset_records}

      %{status: 200, body: %{"records" => records}} ->
        {:ok, Enum.map(records, &Record.new/1)}

      env ->
        {:error, env}
    end
  end

  def fetch_record(table, id, opts \\ %{}) do
    case get(new(), "#{table}/#{id}") do
      %{status: 200, body: record} -> {:ok, Record.new(record)}
      %{status: 404} -> {:error, :not_found}
      env -> {:error, env}
    end
  end

  defmodule Record do
    defstruct [:id, :fields, :created_time]

    use ExConstructor
  end
end
