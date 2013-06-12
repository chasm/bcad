require 'bcrypt'

class SessionsController < ApplicationController
  def new
    render :new, :layout => "public.html.erb"
  end

  def create
    if params[:password].blank?
      begin
        admin = @database["admins"].query.first_example({ email: params[:email] }).first
        admin["code"] = SecureRandom.uuid
        admin["expires_at"] = DateTime.now + 1.day
        admin.save
        
        begin
          UserMailer.reset_email(admin, request).deliver
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
      admin = authenticate(params[:email], params[:password])
    
      if admin
        begin
          login = @database["logins"].create_document({_key: id})
          
          login["admin_id"]      = admin.id
          login["session"]      = session[:session_id]
          login["ip_address"]   = request.remote_ip
          login["admin_agent"]   = request.admin_agent
          login["referer"]      = request.referer
          login["logged_in_at"] = DateTime.now.to_json
          
          login.save
        
          session[:login_id] =  login.id
          admin["login_ids"]  =  admin["login_ids"] || []
          admin["login_ids"]  << login.id
          
          admin.save
        rescue
        end

        session[:user_id] = admin.id
      
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
    begin
      admin = @database["admins"].query.first_example({ email: email }).first
      if admin["fish"] == BCrypt::Engine.hash_secret(password, admin["salt"])
        admin
      else
        nil
      end
    rescue
      nil
    end
  end
end