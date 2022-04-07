defmodule DoctorScheduleWeb.HelloController do
  use DoctorScheduleWeb, :controller

  def call(conn, _params) do
    conn
    |> text("deu certo")
  end
end
