class EmployersController < ApplicationController
  respond_to :json
  
  before_filter :get_user_id

  def index
    employers = @database["employers"].query.by_example({ user_id: @user_id }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    render :json => { employers: employers }
  end

  def show
    employers = @database["employers"].query.by_example({ user_id: @user_id, _key: params[:id] }).map do |x|
      {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
    end
    
    if employers.empty?
      head :not_found
    else
      render :json => { employers: employers }
    end
  end

  def update
    id = params[:id]
    
    employer, status = begin
        [ @database["employers"].query.first_example({ user_id: @user_id, _key: id }).first, :ok ]
      rescue
        begin
          [ @database["employers"].create_document({ _key: id }), :created ]
        rescue Exception => e 
          puts e
        end
      end
    
    employer["user_id"] = @user_id
    employer["name_of_company"]          = params[:employer][:name_of_company]          || employer["name_of_company"]
    employer["phone_number"]             = params[:employer][:phone_number]             || employer["phone_number"]
    employer["email"]                    = params[:employer][:email]                    || employer["email"]
    employer["web_site_url"]             = params[:employer][:web_site_url]             || employer["web_site_url"]
    employer["city"]                     = params[:employer][:city]                     || employer["city"]
    employer["zip_code"]                 = params[:employer][:zip_code]                 || employer["zip_code"]
    employer["job_title"]                = params[:employer][:job_title]                || employer["job_title"]
    employer["name_of_supervisor"]       = params[:employer][:name_of_supervisor]       || employer["name_of_supervisor"]
    employer["from_month"]               = params[:employer][:from_month]               || employer["from_month"]
    employer["from_year"]                = params[:employer][:from_year]                || employer["from_year"]
    employer["to_month"]                 = params[:employer][:to_month]                 || employer["to_month"]
    employer["to_year"]                  = params[:employer][:to_year]                  || employer["to_year"]
    employer["monthly_pay_before_taxes"] = params[:employer][:monthly_pay_before_taxes] || employer["monthly_pay_before_taxes"]

    resp = employer.save
    
    if resp["error"]
      render :json => resp["error"], status: :unprocessable_entity
    else
      employers = @database["employers"].query.by_example({ user_id: @user_id, _key: id }).map do |x|
        {id: x.key}.merge(x.to_hash).reject {|k,v| k == "error" }
      end
      
      render :json => { employers: employers }, :status => status
    end
  end

  def destroy
    begin
      @database["employers"].query.first_example({ user_id: @user_id, _key: params[:id] }).each do |employer|
        employer.delete
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
