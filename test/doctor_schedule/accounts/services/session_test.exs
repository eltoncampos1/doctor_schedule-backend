defmodule DoctorSchedule.Accounts.Services.SessionTest do
  use DoctorSchedule.DataCase

  # import DoctorSchedule.AccountsFixtures

  alias DoctorSchedule.UserFixture

  alias DoctorSchedule.Accounts.Repositories.AccountRepository
  alias DoctorSchedule.Accounts.Services.Session

  describe "users" do
    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(UserFixture.valid_user())
        |> AccountRepository.create_user()

      user
    end

    test "authenticate/2 should return user" do
      user_fixture()

      {:ok, user} = assert Session.authenticate("some_email@email.com", "some_password_hash")

      assert user.email == "some_email@email.com"
    end

    test "authenticate/2 should return error not found if email not exists" do
      {:error, :not_found} =
        assert Session.authenticate("some__invalid_email@email.com", "some_password_hash")
    end

    test "authenticate/2 should return unauthenticated if password is wrong" do
      user_fixture()

      {:error, :unauthorized} =
        assert Session.authenticate("some_email@email.com", "some_invalid_password")
    end
  end
end
