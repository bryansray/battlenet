defmodule BattlenetTest do
  use ExUnit.Case
  doctest Battlenet

  test "should return the appropriate URL" do
    result = Battlenet.API.Base.process_url("/sample_url")

    assert result == "https://us.api.battle.net/sample_url"
  end

  test "should default the region to 'us'" do
  	region = Battlenet.Config.region
  	assert region == "us"
  end

  test "should encode the body" do
  	result = File.read!("./test/data/solution.json")
  	|> Battlenet.API.Base.process_response_body

  	assert true == is_map(result)
  end

  test "should be able to get the members" do
  	
  end
end
