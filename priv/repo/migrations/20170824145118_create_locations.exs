defmodule Test.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :location, :geometry

      timestamps()
    end

  end
end
