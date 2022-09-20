defmodule DoctorScheduleWeb.Api.SessionController do
  use DoctorScheduleWeb, :controller
  alias DoctorScheduleWeb.Auth.Guardian

  action_fallback DoctorScheduleWeb.FallbackController

  def create(conn, %{"email" => email, "password" => pwd}) do
    with {:ok, user, token} <- Guardian.authenticate(email, pwd) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user, token: token})
    end
  end
end
