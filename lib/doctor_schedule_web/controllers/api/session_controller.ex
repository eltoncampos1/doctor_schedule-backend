defmodule DoctorScheduleWeb.Api.SessionController do
  use DoctorScheduleWeb, :controller

  action_fallback DoctorScheduleWeb.FallbackController

  @user %{
    id: "wqe",
    email: "asda",
    first_name: "asd",
    last_name: "isdad"
  }

  def create(conn, %{"email" => email, "password" => pwd}) do
    with {:ok, user, token} <- Guardian.authenticate(email, pwd) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: @user, token: "1212"})
    end
  end
end
