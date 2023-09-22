defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  @doc false
  def price_decrease_changeset(product, attrs) do
    current_unit_price = product.unit_price

    product
    |> cast(attrs, [:unit_price])
    |> validate_number(:unit_price, greater_than: 0.0, less_than_or_equal_to: current_unit_price)
  end
end
