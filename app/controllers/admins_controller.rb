class AdminsController < ApplicationController
  respond_to :json

  def index
    admins = @database["admins"].query.all.map do |x|
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
      admins: admins,
      telephones: telephones,
      employers: employers,
      residences: residences,
      solicitations: solicitations
    }
  end

  def show
    admins = @database["admins"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.by_example({ admin_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload employers
    employers = @database["employers"].query.by_example({ admin_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload residences
    residences = @database["residences"].query.by_example({ admin_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload solicitations
    solicitations = @database["solicitations"].query.by_example({ admin_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if admins.empty?
      head :not_found
    else
      render :json => {
        admins: admins,
        telephones: telephones,
        employers: employers,
        residences: residences,
        solicitations: solicitations
      }
    end
  end

  def update
    id = params[:id]
    
    admin, status = begin
      [ @database["admins"].query.first_example({ _key: id }).first, :ok ]
    rescue
      if email_is_unique
        u = @database["admins"].create_document({_key: id})
        u["email"] = params[:admin][:email]
      else
        render :json => { error: "Email address not available." }, status: :unprocessable_entity
      end
      
      [ u, :created ]
    end
    
    admin["name_first"] = params[:admin][:name_first] || admin["name_first"]
    admin["name_middle"] = params[:admin][:name_middle] || admin["name_middle"]
    admin["name_last"] = params[:admin][:name_last] || admin["name_last"]
    
    resp = admin.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      admins = @database["admins"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
      end
      
      # render :json => { admins: admins }, :status => status
      head status
    end
  end

  def destroy
    begin
      @database["admins"].query.first_example({ _key: params[:id] }).each do |admin|
        admin.delete
      end
      
      @database["telephones"].query.by_example({ admin_id: params[:id] }).each do |telephone|
        telephone.delete
      end
      
      @database["employers"].query.by_example({ admin_id: params[:id] }).each do |employer|
        employer.delete
      end
      
      @database["residences"].query.by_example({ admin_id: params[:id] }).each do |residence|
        residence.delete
      end
      
      @database["solicitations"].query.by_example({ admin_id: params[:id] }).each do |solicitation|
        solicitation.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def email_is_unique
    email = params[:admin][:email] && params[:admin][:email].downcase
    
    begin
      @database["admins"].query.first_example({ email: email }).first
      false
    rescue
      true
    end
  end
  
  def password_confirmation_matches
    params[:password] == params[:password_confirmation]
  end
  
  def encrypt_password(admin, password)
    if admin.present? and password.present?
      admin["salt"] = BCrypt::Engine.generate_salt
      admin["fish"] = BCrypt::Engine.hash_secret(password, user["salt"])
    end
  end
end
