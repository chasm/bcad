class SolicitationsController < ApplicationController
  respond_to :json

  def index
    solicitations = @database["solicitations"].query.all.map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { solicitations: solicitations }
  end

  def show
    solicitations = @database["solicitations"].query.by_example({ _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    applicant_id = solicitations.first["applicant_id"]
    
    # Sideload applicant
    applicants = @database["applicants"].query.by_example({ _key: applicant_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" || k == "salt" || k == "fish" }
    end
    
    # Sideload telephones
    telephones = @database["telephones"].query.by_example({ applicant_id: applicant_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload employers
    employers = @database["employers"].query.by_example({ applicant_id: applicant_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    # Sideload residences
    residences = @database["residences"].query.by_example({ applicant_id: applicant_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if solicitations.empty?
      head :not_found
    else
      render :json => {
        solicitations: solicitations,
        applicants: applicants,
        telephones: telephones,
        employers: employers,
        residences: residences
      }
    end
  end

  def update
    id = params[:id]
    
    solicitation, status = begin
        [ @database["solicitations"].query.first_example({ _key: id }).first, :ok ]
      rescue
        [ @database["solicitations"].create_document({_key: id}), :created ]
      end

    solicitation["status"] = params[:solicitation][:status].downcase if app_statuses.include?( params[:solicitation][:status].downcase ) || solicitation["status"]
    
    solicitation["drivers_license_number"] = params[:solicitation][:drivers_license_number] || solicitation["drivers_license_number"]
    solicitation["date_of_birth"]          = params[:solicitation][:date_of_birth]          || solicitation["date_of_birth"]
    solicitation["social_security_number"] = params[:solicitation][:social_security_number] || solicitation["social_security_number"]
    solicitation["loan_amount"]            = params[:solicitation][:loan_amount]            || solicitation["loan_amount"]
    solicitation["sales_person"]           = params[:solicitation][:sales_person]           || solicitation["sales_person"]
    solicitation["authorized"]             = params[:solicitation][:authorized]             || solicitation["authorized"]
    
    resp = solicitation.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      solicitations = @database["solicitations"].query.by_example({ _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { solicitations: solicitations }, :status => status
    end
  end

  def destroy
    begin
      @database["solicitations"].query.first_example({ _key: params[:id] }).each do |solicitation|
        solicitation.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
end
