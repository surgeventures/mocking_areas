import Config

config :mocking_areas, MockingAreas.AreaAccess,
  mocking_enabled: Mix.env() == :test
