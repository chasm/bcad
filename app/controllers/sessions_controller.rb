require 'bcrypt'

class SessionsController < ApplicationController
  def new
    render :new, :layout => "public.html.erb"
  end

  def create
    if params[:password].blank?
      begin
        user = @database["users"].query.first_example({ email: params[:email] }).first
        user["code"] = SecureRandom.uuid
        user["expires_at"] = DateTime.now + 1.day
        user.save
        
        begin
          UserMailer.reset_email(user, request).deliver
        rescue
          flash.now.alert = "There was a problem sending email. Please try again later or contact the webmaster."
      
          render "new"
        end
        
        redirect_to login_url, notice: "Your password reset email has been sent. Please check your email inbox."
      rescue
        flash.now.alert = "Email address not found"
      
        render "new"
      end
    else
      user = authenticate(params[:email], params[:password])
    
      if user
        begin
          login = @database["logins"].create_document({_key: id})
          login["user_id"] = user.id
          login["session"] = session[:session_id]
          login["ip_address"] = request.remote_ip
          login["user_agent"] = request.user_agent
          login["referer"] = request.referer
          login["logged_in_at"] = DateTime.now.to_json
          login.save
        
          session[:login_id] = login.id
          user["login_ids"] = user["login_ids"] || []
          user["login_ids"] << login.id
          user.save
        rescue
        end

        session[:user_id] = user.id
      
        redirect_to root_url
      else
        flash.now.alert = "Invalid email or password"
      
        render "new"
      end
    end
  end

  def destroy
    begin
      if login = @database["logins"].query.first_example({ _key: session[:login_id] }).first
        login["logged_out_at"] = DateTime.now.to_json
        login.save
      end
    rescue
    end

    session[:user_id] = nil
    session[:login_id] = nil
    
    redirect_to login_url
  end
  
  private
  
  def authenticate(email, password)
    if user = @database["users"].query.first_example({ email: email }).first
      if user["fish"] == BCrypt::Engine.hash_secret(password, user["salt"])
        user
      else
        nil
      end
    else
      nil
    end
  end
end