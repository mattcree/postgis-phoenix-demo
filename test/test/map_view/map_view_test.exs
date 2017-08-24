defmodule Test.MapViewTest do
  use Test.DataCase

  alias Test.MapView

  describe "locations" do
    alias Test.MapView.Location

    @valid_attrs %{location: "some location"}
    @update_attrs %{location: "some updated location"}
    @invalid_attrs %{location: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MapView.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert MapView.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert MapView.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = MapView.create_location(@valid_attrs)
      assert location.location == "some location"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MapView.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, location} = MapView.update_location(location, @update_attrs)
      assert %Location{} = location
      assert location.location == "some updated location"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = MapView.update_location(location, @invalid_attrs)
      assert location == MapView.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = MapView.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> MapView.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = MapView.change_location(location)
    end
  end
end
