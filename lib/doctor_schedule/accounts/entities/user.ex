defmodule DoctorSchedule.Accounts.Entities.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required [:email, :first_name, :last_name, :password, :password_confirmation]

  @derive {Phoenix.Param, key: :id}
  schema "users" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: pwd}} = changeset) do
    change(changeset, Argon2.add_hash(pwd))
  end

  defp hash_password(changeset) do
    changeset
  end
end
