class ResidencesController < ApplicationController
  respond_to :json
  
  before_filter :get_user_id

  def index
    residences = @database["residences"].query.by_example({ user_id: @user_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { residences: residences }
  end

  def show
    residences = @database["residences"].query.by_example({ user_id: @user_id, _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if residences.empty?
      head :not_found
    else
      render :json => { residences: residences }
    end
  end

  def update
    id = params[:id]
    
    residence, status = begin
        [ @database["residences"].query.first_example({ user_id: @user_id, _key: id }).first, :ok ]
      rescue
        begin
          [ @database["residences"].create_document({ _key: id }), :created ]
        rescue Exception => e 
          puts e
        end
      end
    
    residence["user_id"] = @user_id
    residence["address_line_one"]         = params[:residence][:address_line_one]         || residence["address_line_one"]
    residence["address_line_two"]         = params[:residence][:address_line_two]         || residence["address_line_two"]
    residence["city"]                     = params[:residence][:city]                     || residence["city"]
    residence["zip_code"]                 = params[:residence][:zip_code]                 || residence["zip_code"]
    residence["city"]                     = params[:residence][:city]                     || residence["city"]
    residence["zip_code"]                 = params[:residence][:zip_code]                 || residence["zip_code"]
    residence["is_owner"]                 = params[:residence][:is_owner]                 || residence["is_owner"]
    residence["from_month"]               = params[:residence][:from_month]               || residence["from_month"]
    residence["from_year"]                = params[:residence][:from_year]                || residence["from_year"]
    residence["to_month"]                 = params[:residence][:to_month]                 || residence["to_month"]
    residence["to_year"]                  = params[:residence][:to_year]                  || residence["to_year"]
    residence["monthly_rent_or_mortgage"] = params[:residence][:monthly_rent_or_mortgage] || residence["monthly_rent_or_mortgage"]

    resp = residence.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      residences = @database["residences"].query.by_example({ user_id: @user_id, _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { residences: residences }, :status => status
    end
  end

  def destroy
    begin
      @database["residences"].query.first_example({ user_id: @user_id, _key: params[:id] }).each do |residence|
        residence.delete
      end
      
      head :no_content
    rescue
      head :not_found
    end
  end
  
  private
  
  def get_user_id
    @user_id = params[:user_id]
    
    head :unprocessable_entity unless @user_id
  end
end
