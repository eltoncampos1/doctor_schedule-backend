defmodule DoctorScheduleWeb.Api.UserControllerTest do
  use DoctorScheduleWeb.ConnCase

  import DoctorSchedule.AccountsFixtures

  alias DoctorSchedule.Accounts.Entities.User
  alias DoctorSchedule.Accounts.Repositories.AccountRepository

  alias DoctorSchedule.UserFixture

  import DoctorScheduleWeb.Auth.Guardian

  @valid_user %{
    email: "auth@email.com",
    first_name: "first_name",
    last_name: "some_last_name",
    password: "some_password_hash",
    password_confirmation: "some_password_hash"
  }

  setup %{conn: conn} do
    {:ok, user} = AccountRepository.create_user(@valid_user)

    {:ok, token, _claims} = encode_and_sign(user, %{}, token_type: :access)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer " <> token)

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn =
        conn
        |> get(Routes.api_user_path(conn, :index))

      assert json_response(conn, 200) |> Enum.count() == 1
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.valid_user())
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "email" => "some_email@email.com",
               "first_name" => "first_name",
               "last_name" => "some_last_name"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_user_path(conn, :create), user: UserFixture.invalid_user())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.api_user_path(conn, :update, user), user: UserFixture.update_user())
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.api_user_path(conn, :show, id))

      assert %{
               "email" => "some_update_email@email.com",
               "first_name" => "first_name up",
               "last_name" => "some_last_name up"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn =
        put(conn, Routes.api_user_path(conn, :update, user), user: UserFixture.invalid_user())

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.api_user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
