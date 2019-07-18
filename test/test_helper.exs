Mox.defmock(MockingAreas.Second.Mock, for: MockingAreas.Second)
Application.put_env(:mocking_areas, MockingAreas.Second, impl: MockingAreas.Second.Mock)
ExUnit.start()
