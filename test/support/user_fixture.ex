defmodule DoctorSchedule.UserFixture do
  def valid_user do
    %{
      email: "some_email@email.com",
      first_name: "first_name",
      last_name: "some_last_name",
      password: "some_password_hash",
      password_confirmation: "some_password_hash"
    }
  end

  def update_user do
    %{
      email: "some_update_email@email.com",
      first_name: "first_name up",
      last_name: "some_last_name up",
      password: "some_password_hash",
      password_confirmation: "some_password_hash"
    }
  end

  def invalid_user do
    %{
      email: "invalid email.com",
      first_name: "first_name",
      last_name: "some_last_name",
      password: "some_password_hash",
      password_confirmation: "some_password_invalid"
    }
  end
end
