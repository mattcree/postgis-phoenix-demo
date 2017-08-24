defmodule Test.MapView.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias Test.MapView.Location

  schema "locations" do
    field :location, Geo.Geometry
    field :lat, :float, virtual: true
    field :long, :float, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%Location{} = location, attrs) do
    fixed_attrs = parse_location(attrs)
    cast(location, fixed_attrs, [:location])
    |> validate_required([:location])
  end

  def parse_location(location) do
    lat_string = Map.get(location, "lat")
    long_string = Map.get(location, "long")
    if lat_string == nil or long_string == nil do
      %{"location" => nil}
    else
      point = "SRID=4326;POINT(#{long_string} #{lat_string})"
      geopoint = Geo.WKT.decode(point)
      %{"location" => geopoint}
    end
  end

end
