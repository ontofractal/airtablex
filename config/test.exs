use Mix.Config

config :airtable,
  api_key: System.get_env("AIRTABLE_API_KEY") ,
  base: System.get_env("AIRTABLE_BASE")  # test_module base
