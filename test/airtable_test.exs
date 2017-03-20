defmodule AirtableTest do
  use PowerAssert

  test "get all rows for table_red records" do
    {:ok, data} = Airtable.fetch_records("table_red")
    assert (hd data).fields == %{"Name" => "Second element"}
  end

end
