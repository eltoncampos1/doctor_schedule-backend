defmodule DoctorScheduleWeb.Api.SessionControllerTest do
  use DoctorScheduleWeb.ConnCase

  alias DoctorSchedule.Accounts.Repositories.AccountRepository

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

  describe "sesstion test" do
    test "should authenticate with valid user", %{conn: conn} do
      params = %{
        email: "auth@email.com",
        password: "some_password_hash"
      }

      conn =
        conn
        |> post(Routes.api_session_path(conn, :create), params)

      assert json_response(conn, 201)
      assert json_response(conn, 201)["user"]["email"] == params.email
    end

    test "should not authenticate with invalid user", %{conn: conn} do
      params = %{
        email: "invalid@email.com",
        password: "invalid_password"
      }

      conn =
        conn
        |> post(Routes.api_session_path(conn, :create), params)

      assert json_response(conn, 400)
      # assert json_response(conn, 201)["user"]["email"] == params.email
    end
  end
end
