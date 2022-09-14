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
        email: "some_email@email.com",
        first_name: "first_name",
        last_name: "some_last_name",
        password: "some_password_hash",
        password_confirmation: "some_password_hash"
      })
      |> AccountRepository.create_user()

    user
  end
end
