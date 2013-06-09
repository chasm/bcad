class PasswordsController < ApplicationController
  def edit
    begin
      @database["users"].query.first_example({ code: params[:code] }).first

      render :edit, :layout => "public.html.erb"
    rescue
      redirect_to login_url, alert: "Sorry, your reset link has expired. Please try again."
    end
  end

  def update
  end
end
