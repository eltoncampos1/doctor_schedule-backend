defmodule DoctorSchedule.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DoctorSchedule.Accounts` context.
  """

  @doc """
  Generate a user.
  """

  alias DoctorSchedule.Accounts.Repositories.AccountRepository
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        password_hash: "some password_hash",
        role: "some role"
      })
      |> AccountRepository.create_user()

    user
  end
end
