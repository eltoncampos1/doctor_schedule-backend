defmodule DoctorSchedule.Accounts.Repositories.AccountsRepositoryTest do
  use DoctorSchedule.DataCase

  import DoctorSchedule.AccountsFixtures

  alias DoctorSchedule.Accounts.Entities.User
  alias DoctorSchedule.Accounts.Repositories.AccountRepository

  describe "users" do
    @invalid_attrs %{
      email: "invalid",
      first_name: nil,
      last_name: nil,
      password: "abc",
      password_confirmation: "cbs"
    }

    test "list_users/0 returns all users" do
      user_fixture()
      assert AccountRepository.list_users() |> Enum.count() == 1
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert AccountRepository.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some@email",
        first_name: "first_name",
        last_name: "last_name",
        password: "some password",
        password_confirmation: "some password"
      }

      assert {:ok, %User{} = user} = AccountRepository.create_user(valid_attrs)
      assert user.email == "some@email"
      assert user.first_name == "first_name"
      assert user.last_name == "last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountRepository.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some_updated@email",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        password: "some_password_hash",
        password_confirmation: "some_password_hash"
      }

      assert {:ok, %User{} = user} = AccountRepository.update_user(user, update_attrs)
      assert user.email == "some_updated@email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountRepository.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = AccountRepository.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> AccountRepository.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = AccountRepository.change_user(user)
    end
  end
end
