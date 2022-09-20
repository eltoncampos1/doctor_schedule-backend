defmodule DoctorSchedule.Accounts.Services.SendForgotPasswordToEmail do
  def execute(email) do
    {:ok, "user", "token", email}
  end
end
