defmodule ShipTest do
  use ExUnit.Case

  alias Barquinhos.Game.Ship

  test "create a horizontal submarine at 0,0" do
    ship = Ship.new({0, 0}, :horizontal, :submarine)

    assert ship.orientation == :horizontal
    assert ship.size == 3
    assert ship.type == :submarine
    assert ship.starting_point == {0, 0}
  end

  test "returns the vertical points based on ship size" do
    ship = %Ship{starting_point: {5, 5}}

    assert Ship.to_points(ship) == [{5, 5}, {5, 6}, {5, 7}]
  end

  test "returns the horizontal points based on ship size" do
    ship = %Ship{starting_point: {5, 5}, orientation: :horizontal}

    assert Ship.to_points(ship) == [{5, 5}, {6, 5}, {7, 5}]
  end

  test "A shot at {5,6} hits an horizontal ship of size 3 that starts at {5,5}" do
    ship = %Ship{starting_point: {5, 5}}

    assert Ship.hit?(ship, {5, 6})
  end

  test "A shot at {6,6} does not hit an horizontal ship of size 3 that starts at {5,5}" do
    ship = %Ship{starting_point: {5, 5}}

    refute Ship.hit?(ship, {6, 6})
  end

  test "An horizontal ship of size 3 that starts at {5,5} is sunk by
   [{5,5}, {5,6}, {5,7}]" do
    ship = %Ship{starting_point: {5, 5}}

    assert Ship.sunk?(ship, [{5, 5}, {5, 6}, {5, 7}])
  end

  test "An horizontal ship of size 3 that starts at {5,5} is NOT sunk by
  [{5,5}, {5,7}, {5,8}]" do
    ship = %Ship{starting_point: {5, 5}}

    refute Ship.sunk?(ship, [{5, 5}, {5, 7}, {5, 8}])
  end
end
