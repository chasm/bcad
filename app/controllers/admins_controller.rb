class UsersController < ApplicationController
  respond_to :json

  def index
    users = @database["users"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload employers
    employers = @database["employers"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload residences
    residences = @database["residences"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload solicitations
    solicitations = @database["solicitations"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => {
      users: users,
      telephones: telephones,
      employers: employers,
      residences: residences,
      solicitations: solicitations
    }
  end

  def show
    users = @database["users"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.by_example({ user_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload employers
    employers = @database["employers"].query.by_example({ user_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload residences
    residences = @database["residences"].query.by_example({ user_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload solicitations
    solicitations = @database["solicitations"].query.by_example({ user_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if users.empty?
      head :not_found
    else
      render :json => {
        users: users,
        telephones: telephones,
        employers: employers,
        residences: residences,
        solicitations: solicitations
      }
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
    
    user["name_first"] = params[:user][:name_first] || user["name_first"]
    user["name_middle"] = params[:user][:name_middle] || user["name_middle"]
    user["name_last"] = params[:user][:name_last] || user["name_last"]
    
    resp = user.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      users = @database["users"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
      end
      
      # render :json => { users: users }, :status => status
      head status
    end
  end

  def destroy
    begin
      @database["users"].query.first_example({ _key: params[:id] }).each do |user|
        user.delete
      end
      
      @database["telephones"].query.by_example({ user_id: params[:id] }).each do |telephone|
        telephone.delete
      end
      
      @database["employers"].query.by_example({ user_id: params[:id] }).each do |employer|
        employer.delete
      end
      
      @database["residences"].query.by_example({ user_id: params[:id] }).each do |residence|
        residence.delete
      end
      
      @database["solicitations"].query.by_example({ user_id: params[:id] }).each do |solicitation|
        solicitation.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def email_is_unique
    email = params[:user][:email] && params[:user][:email].downcase
    
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
