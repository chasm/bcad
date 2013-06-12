class ApplicantsController < ApplicationController
  respond_to :json

  def index
    applicants = @database["applicants"].query.all.map do |x|
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
      applicants: applicants,
      telephones: telephones,
      employers: employers,
      residences: residences,
      solicitations: solicitations
    }
  end

  def show
    applicants = @database["applicants"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.by_example({ applicant_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload employers
    employers = @database["employers"].query.by_example({ applicant_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload residences
    residences = @database["residences"].query.by_example({ applicant_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload solicitations
    solicitations = @database["solicitations"].query.by_example({ applicant_id: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if applicants.empty?
      head :not_found
    else
      render :json => {
        applicants: applicants,
        telephones: telephones,
        employers: employers,
        residences: residences,
        solicitations: solicitations
      }
    end
  end

  def update
    id = params[:id]
    
    applicant, status = begin
      [ @database["applicants"].query.first_example({ _key: id }).first, :ok ]
    rescue
      if email_is_unique
        u = @database["applicants"].create_document({_key: id})
        u["email"] = params[:applicant][:email]
      else
        render :json => { error: "Email address not available." }, status: :unprocessable_entity
      end
      
      [ u, :created ]
    end
    
    applicant["name_first"] = params[:applicant][:name_first] || applicant["name_first"]
    applicant["name_middle"] = params[:applicant][:name_middle] || applicant["name_middle"]
    applicant["name_last"] = params[:applicant][:name_last] || applicant["name_last"]
    
    resp = applicant.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      applicants = @database["applicants"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
      end
      
      # render :json => { applicants: applicants }, :status => status
      head status
    end
  end

  def destroy
    begin
      @database["applicants"].query.first_example({ _key: params[:id] }).each do |applicant|
        applicant.delete
      end
      
      @database["telephones"].query.by_example({ applicant_id: params[:id] }).each do |telephone|
        telephone.delete
      end
      
      @database["employers"].query.by_example({ applicant_id: params[:id] }).each do |employer|
        employer.delete
      end
      
      @database["residences"].query.by_example({ applicant_id: params[:id] }).each do |residence|
        residence.delete
      end
      
      @database["solicitations"].query.by_example({ applicant_id: params[:id] }).each do |solicitation|
        solicitation.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def email_is_unique
    email = params[:applicant][:email] && params[:applicant][:email].downcase
    
    begin
      @database["applicants"].query.first_example({ email: email }).first
      false
    rescue
      true
    end
  end
  
  def password_confirmation_matches
    params[:password] == params[:password_confirmation]
  end
  
  def encrypt_password(applicant, password)
    if applicant.present? and password.present?
      applicant["salt"] = BCrypt::Engine.generate_salt
      applicant["fish"] = BCrypt::Engine.hash_secret(password, applicant["salt"])
    end
  end
end
