import Config

config :modular,
  area_mocking_enabled: Mix.env() == :test,
  areas: [
    MockingAreas.First,
    MockingAreas.Second,
    MockingAreas.Third,
    OtherApp.Fourth
  ]
