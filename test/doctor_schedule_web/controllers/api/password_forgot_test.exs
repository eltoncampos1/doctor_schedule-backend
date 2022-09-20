defmodule DoctorScheduleWeb.Api.PasswordForgotControllerTest do
  use DoctorScheduleWeb.ConnCase

  alias DoctorSchedule.AccountsFixtures

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end

  test "should send email to forgot password", %{conn: conn} do
    user = AccountsFixtures.user_fixture()

    conn =
      conn
      |> post(Routes.api_password_forgot_path(conn, :create), email: user.email)

    assert conn.status == 204
  end
end
