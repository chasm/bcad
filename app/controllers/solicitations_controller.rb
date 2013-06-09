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
    
    if solicitations.empty?
      head :not_found
    else
      render :json => { solicitations: solicitations }
    end
  end

  def update
    id = params[:id]
    
    solicitation, status = begin
        [ @database["solicitations"].query.first_example({ _key: id }).first, :ok ]
      rescue
        [ @database["solicitations"].create_document({_key: id}), :created ]
      end
    
    solicitation["drivers_license_number"] = params[:solicitation][:drivers_license_number]
    solicitation["date_of_birth"] = params[:solicitation][:date_of_birth]
    solicitation["social_security_number"] = params[:solicitation][:social_security_number]
    solicitation["loan_amount"] = params[:solicitation][:loan_amount]
    solicitation["sales_person"] = params[:solicitation][:sales_person]
    solicitation["authorized"] = params[:solicitation][:authorized]
    solicitation["status"] = params[:solicitation][:status]
    
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
      solicitations = @database["solicitations"].query.first_example({ _key: params[:id] }).each do |solicitation|
        solicitation.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
end
