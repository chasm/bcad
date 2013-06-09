class UsersController < ApplicationController
  respond_to :json

  def index
    users = @database["users"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { users: users, telephones: telephones }
  end

  def show
    users = @database["users"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if users.empty?
      head :not_found
    else
      render :json => { users: users }
    end
  end

  def update
    id = params[:id]
    
    user, status = begin
      [ @database["users"].query.first_example({ _key: id }).first, :ok ]
    rescue
      if email_is_unique
        u = @database["users"].create_document({_key: id})
        u["email"] = params[:user][:email]
      else
        render :json => { error: "Email address not available." }, status: :unprocessable_entity
      end
      
      [ u, :created ]
    end
    
    user["name_first"] = params[:user][:name_first]
    user["name_middle"] = params[:user][:name_middle]
    user["name_last"] = params[:user][:name_last]
    
    resp = user.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      users = @database["users"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { users: users }, :status => status
    end
  end

  def destroy
    begin
      users = @database["users"].query.first_example({ _key: params[:id] }).each do |user|
        user.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def email_is_unique
    email = params[:user][:email] && params[:user][:email].downcase
    puts ">>>> EMAIL:"; puts email
    begin
      @database["users"].query.first_example({ email: email }).first
      false
    rescue
      true
    end
  end
  
  def password_confirmation_matches
    params[:password] == params[:password_confirmation]
  end
  
  def encrypt_password(user, password)
    if user.present? and password.present?
      user["salt"] = BCrypt::Engine.generate_salt
      user["fish"] = BCrypt::Engine.hash_secret(password, user["salt"])
    end
  end
end
